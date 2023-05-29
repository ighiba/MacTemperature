//
//  TemperatureManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

class TemperatureManager {
    
    
    init() {
        
    }
    
    func updateTempValue(_ value: UnsafeMutablePointer<SMCVal_t>) {
        let result = AppleSMC.shared.read(value)
        if result != kIOReturnSuccess {
            fatalError("Error")
        }
    }
    
    func getAverageTempFor(_ values: [SMCVal_t]) -> Float {
        let temps = values.map { Float($0.bytes) ?? 0.0 }
        let sum = temps.reduce(0, +)
        
        return sum / Float(temps.count)
    }
    
    
}
