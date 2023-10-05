//
//  TemperatureManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

protocol TemperatureManager: AnyObject {
    func obtainTemperature(for sensor: Sensor) -> Float?
}

class TemperatureManagerImpl: TemperatureManager {
    
    func obtainTemperature(for sensor: Sensor) -> Float? {
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
