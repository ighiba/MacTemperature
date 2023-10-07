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
    
    private let sensorsManager: SensorsManager
    
    init(sensorsManager: SensorsManager) {
        self.sensorsManager = sensorsManager
        self.addTemperatureDataObserver()
        self.temperatureData = self.getInitalData()
    }
    
    private func addTemperatureDataObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTemperatureData), name: .temperatureMonitorUpdateNotification, object: nil)
    }
    
    @objc func updateTemperatureData(_ notification: NSNotification) {
        guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
        DispatchQueue.main.async { [weak self] in
            self?.temperatureData = tempMonitorData.transformIntoTemperatureData()
        }
    }
    
    private func getInitalData() -> [TemperatureData] {
        let tempData = TemperatureMonitor.lastData.transformIntoTemperatureData()
        return !tempData.isEmpty ? tempData : getEmptyTemperatureData()
    }
    
    private func getEmptyTemperatureData() -> [TemperatureData] {
        let sensors = sensorsManager.getCurrentDeviceSensors(sensorTypes: [.cpu, .gpu])
        return sensors.map { TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0) }
    }
}
