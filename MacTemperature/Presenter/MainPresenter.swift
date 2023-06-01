//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func getSampleData() -> [TemperatureData]
}

protocol MainViewInput: AnyObject {
    func updateRows(data: [TemperatureData])
}

class MainPresenter: MainViewOutput {
    
    weak var input: MainViewInput!
    
    weak var sensorsManager: SensorsManager!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMainViewRows), name: TemperatureMonitor.temperatureUpdateNotifaction, object: nil)
    }
    
    deinit {
        print("MainPresenter deinited")
    }
    
    @objc func updateMainViewRows(_ notification: NSNotification) {
        guard let values = notification.object as? [SMCVal_t] else { return }
        DispatchQueue.main.async { [weak self] in
            let tempData = values.map {
                TemperatureData(smcValue: $0)
            }
            self?.input.updateRows(data: tempData)
        }
    }

    func getSampleData() -> [TemperatureData] {
        let values = sensorsManager.getValues(Sensor.allCases)
        let tempStatusData = values.map {
            TemperatureData(smcValue: $0)
        }
        return tempStatusData
    }
    
}
