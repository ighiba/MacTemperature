//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    func startMeasuringTemperature()
}

protocol MainViewInput: AnyObject {
    func updateRows(data: [TemperatureStatusData])
}

class MainPresenter: MainViewOutput {
    
    weak var input: MainViewInput!
    
    var temperatureManager: TemperatureManager!
    
    
    func startMeasuringTemperature() {
        
        var values = SensorsManager().getValues(Sensor.allCases)
    
        DispatchQueue.global().async {
            while true {
                sleep(1)
                for i in 0..<values.count {
                    self.temperatureManager.updateTempValue(&values[i])
                }
                
                DispatchQueue.main.async {
                    let tempStatusData = values.map {
                        TemperatureStatusData(smcValue: $0)
                    }
                    self.input.updateRows(data: tempStatusData)
                }
                
            }
        }
    }
}
