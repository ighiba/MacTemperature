//
//  MenuViewModel.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Cocoa

protocol MenuViewModelDelegate: AnyObject {
    var temperatureMonitorData: TemperatureMonitorData { get }
    var temperatureMonitorDataPublisher: Published<TemperatureMonitorData>.Publisher { get }
    func terminateApplication()
    func showMainWindow()
    func showSettingsWindow()
}

class MenuViewModel: MenuViewModelDelegate {
    
    private let menuBarSettings: MenuBarSettingsData
    
    @Published var temperatureMonitorData: TemperatureMonitorData = [:]
    var temperatureMonitorDataPublisher: Published<TemperatureMonitorData>.Publisher { $temperatureMonitorData }
    
    init(menuBarSettings: MenuBarSettingsData) {
        self.menuBarSettings = menuBarSettings
        self.loadInitialData(forSettings: menuBarSettings)
        self.configureNotification()
    }
    
    private func loadInitialData(forSettings settings: MenuBarSettingsData) {
        if settings.cpuShowTemperatures {
            temperatureMonitorData[.cpu] = loadInitialData(for: .cpu)
        }
        
        if settings.gpuShowTemperatures {
            temperatureMonitorData[.gpu] = loadInitialData(for: .gpu)
        }
    }
    
    private func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData] {
        let tempStatusData = TemperatureMonitor.lastData[type] ?? []
        return !tempStatusData.isEmpty ? tempStatusData : getSampleData(for: type)
    }
    
    private func getSampleData(for type: TemperatureSensorType) -> [TemperatureData] {
        let sensorsManager = SensorsManagerImpl()
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [type])
        return sensors.map { TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0) }
    }
    
    private func configureNotification() {
        NotificationCenter.default.addObserver(forName: .temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
            DispatchQueue.main.async {
                self?.temperatureMonitorData = tempMonitorData
            }
        }
    }

    func terminateApplication() {
        NSApplication.shared.terminate(nil)
    }
    
    func showMainWindow() {
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.showMainWindow()
    }
    
    func showSettingsWindow() {
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.showSettingsWindow()
    }
}
