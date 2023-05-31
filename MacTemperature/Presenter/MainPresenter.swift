//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func getSampleData() -> [TemperatureStatusData]
}

protocol MainViewInput: AnyObject {
    func updateRows(data: [TemperatureStatusData])
}

class MainPresenter: MainViewOutput {
    
    weak var input: MainViewInput!

    var sensorsManager: SensorsManager!
    
    init() {
        NotificationCenter.default.addObserver(forName: TemperatureMonitor.temperatureUpdateNotifaction, object: nil, queue: nil) { notification in
            if let values = notification.object as? [SMCVal_t] {
                DispatchQueue.main.async {
                    let tempStatusData = values.map {
                        TemperatureStatusData(smcValue: $0)
                    }
                    self.input.updateRows(data: tempStatusData)
                }
            }
        }
    }
    
    func getSampleData() -> [TemperatureStatusData] {
        let values = sensorsManager.getValues(Sensor.allCases)
        let tempStatusData = values.map {
            TemperatureStatusData(smcValue: $0)
        }
        return tempStatusData
    }
    
}
