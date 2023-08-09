//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func getSampleData() -> [TemperatureData]
    func loadAndUpdateInitalData()
}

protocol MainViewInput: AnyObject {
    func updateRows(data: [TemperatureData])
}

class MainPresenter: MainViewOutput {
    
    weak var input: MainViewInput!
    
    var sensorsManager: SensorsManager!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMainViewRows), name: NotificationNames.temperatureUpdateNotifaction, object: nil)
    }
    
    deinit {
        print("MainPresenter deinited")
    }
    
    @objc func updateMainViewRows(_ notification: NSNotification) {
        guard let tempMonitorData = notification.object as? TemperatureMonitorData else { return }
        DispatchQueue.main.async { [weak self] in
            
            let tempData = tempMonitorData.transformIntoTemperatureData()

            self?.input.updateRows(data: tempData)
        }
    }

    func loadInitalData() -> [TemperatureData] {
        let tempData = TemperatureMonitor.lastData.transformIntoTemperatureData()
        return !tempData.isEmpty ? tempData : self.getSampleData()
    }
    
    func getSampleData() -> [TemperatureData] {
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [.cpu, .gpu])
        let tempStatusData = sensors.map {
            TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0)
        }
        return tempStatusData
    }
    
    func loadAndUpdateInitalData() {
        let data = loadInitalData()
        self.input.updateRows(data: data)
    }
}
