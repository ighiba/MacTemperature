//
//  TemperatureManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

protocol TemperatureManager: AnyObject {
    func getTemperature(for sensor: Sensor) -> Float?
    func getAverageTemperatureFor(_ data: [TemperatureData]) -> Float
}

class TemperatureManagerImpl: TemperatureManager {
    
    func getAverageTemperatureFor(_ data: [TemperatureData]) -> Float {
        guard !data.isEmpty else { return 0 }
        let temps = data.map({ $0.floatValue })
        let sum = temps.reduce(0, +)
        
        return sum / Float(temps.count)
    }
    
    func getTemperature(for sensor: Sensor) -> Float? {
        var value = SMCVal_t(sensor.key)
        var result: kern_return_t
        
        result = AppleSMC.shared.read(&value)
        if result != kIOReturnSuccess {
            return nil
        }
        
        if value.dataType == "flt " {
            return Float(value.bytes)
        }

        return nil
    }
}
