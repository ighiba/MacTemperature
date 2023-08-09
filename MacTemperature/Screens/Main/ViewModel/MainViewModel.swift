//
//  MainViewModel.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Foundation

protocol TemperatureDataSource: ObservableObject {
    var temperatureData: [TemperatureData] { get }
}

class MainViewModel: TemperatureDataSource {
    
    @Published var temperatureData: [TemperatureData] = []
    
    var sensorsManager: SensorsManager!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTemperatureData), name: NotificationNames.temperatureUpdateNotifaction, object: nil)
        loadAndUpdateInitalData()
    }
    
    deinit {
        print("MainViewModel deinited")
    }
    
    @objc func updateTemperatureData(_ notification: NSNotification) {
        guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
        DispatchQueue.main.async { [weak self] in
            self?.temperatureData = tempMonitorData.transformIntoTemperatureData()
        }
    }
    
    func loadAndUpdateInitalData() {
        temperatureData = loadInitalData()
    }
    
    func loadInitalData() -> [TemperatureData] {
        let tempData = TemperatureMonitor.lastData.transformIntoTemperatureData()
        return !tempData.isEmpty ? tempData : getSampleData()
    }
    
    func getSampleData() -> [TemperatureData] {
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [.cpu, .gpu])
        return sensors.map { TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0) }
    }
}
