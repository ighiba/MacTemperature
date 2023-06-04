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
    
    init() {
        
    }
//    
//    func updateTemperatureValue(_ value: UnsafeMutablePointer<SMCVal_t>) {
//        let result = AppleSMC.shared.read(value)
//        if result != kIOReturnSuccess {
//            fatalError("Error")
//        }
//    }
    
    func getAverageTemperatureFor(_ data: [TemperatureData]) -> Float {
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
