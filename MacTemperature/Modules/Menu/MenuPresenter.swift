//
//  MenuPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

protocol MenuOutput: AnyObject {
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData]
    func terminateApplication()
    func showMainWindow()
    func showSettingsWindow()
}

class MenuPresenter: MenuOutput {
    
    weak var input: MenuInput!
    
    init() {
        NotificationCenter.default.addObserver(forName: NotificationNames.temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
            DispatchQueue.main.async {
                
                let cpuData = tempMonitorData[.cpu] ?? []
                self?.input.updateCpuRows(data: cpuData)
                
                let gpuData = tempMonitorData[.gpu] ?? []
                self?.input.updateGpuRows(data: gpuData)
            }
        }
    }

    func terminateApplication() {
        NSApplication.shared.terminate(nil)
    }
    
    func showMainWindow() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.showMainWindow()
    }
    
    func showSettingsWindow() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.showSettingsWindow()
    }
    
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData] {
        let tempStatusData = TemperatureMonitor.lastData[type] ?? []
        return !tempStatusData.isEmpty ? tempStatusData : getSampleData(for: type)
    }
    
    private func getSampleData(for type: TemperatureSensorType) -> [TemperatureData] {
        let sensorsManager = SensorsManagerImpl()
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [type])
        let tempStatusData = sensors.map {
            TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0)
        }
        return tempStatusData
    }
}
