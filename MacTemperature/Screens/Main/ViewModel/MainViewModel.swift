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
        NotificationCenter.default.addObserver(self, selector: #selector(updateTemperatureData), name: .temperatureUpdateNotifaction, object: nil)
        temperatureData = getInitalData()
    }
    
    @objc func updateTemperatureData(_ notification: NSNotification) {
        guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
        DispatchQueue.main.async { [weak self] in
            self?.temperatureData = tempMonitorData.transformIntoTemperatureData()
        }
    }
    
    func getInitalData() -> [TemperatureData] {
        let tempData = TemperatureMonitor.lastData.transformIntoTemperatureData()
        return !tempData.isEmpty ? tempData : getEmptyTemperatureData()
    }
    
    func getEmptyTemperatureData() -> [TemperatureData] {
        let sensors = sensorsManager.getCurrentDeviceSensors([.cpu, .gpu])
        return sensors.map { TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0) }
    }
}
