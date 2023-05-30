//
//  SensorsManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

protocol SensorsManager {
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t]
}

class SensorsManagerImpl: SensorsManager {
    
    init() {
        
    }
    
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t] {
        guard !sensors.isEmpty else { return [] }
        return sensors.map({ SMCVal_t($0.key) })
    }
}
