//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func getSampleData() -> [TemperatureStatusData]
    func startMeasuringTemperature()
}

protocol MainViewInput: AnyObject {
    func updateRows(data: [TemperatureStatusData])
}

class MainPresenter: MainViewOutput {
    
    weak var input: MainViewInput!
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    func getSampleData() -> [TemperatureStatusData] {
        let values = sensorsManager.getValues(Sensor.allCases)
        let tempStatusData = values.map {
            TemperatureStatusData(smcValue: $0)
        }
        return tempStatusData
    }
    
    func startMeasuringTemperature() {
        var values = sensorsManager.getValues(Sensor.allCases)
    
        DispatchQueue.global().async {
            while true {
                for i in 0..<values.count {
                    self.temperatureManager.updateTemperatureValue(&values[i])
                }
                
                DispatchQueue.main.async {
                    let tempStatusData = values.map {
                        TemperatureStatusData(smcValue: $0)
                    }
                    self.input.updateRows(data: tempStatusData)
                    
                    let avgCPUTemp = self.temperatureManager.getAverageTemperatureFor(values)
                    StatusBarManager.shared.updateTemperature(avgCPUTemp)
                }
                sleep(1)
            }
        }
    }
    
}
