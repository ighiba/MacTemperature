//
//  SensorsManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

protocol SensorsManager: AnyObject {
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t]
    func getCurrentDeviceSensors(_ sensorTypes: [TemperatureSensorType]) -> [Sensor]
}

class SensorsManagerImpl: SensorsManager {
    
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t] {
        guard !sensors.isEmpty else { return [] }
        return sensors.map({ SMCVal_t($0.key) })
    }
    
    func getCurrentDeviceSensors(_ sensorTypes: [TemperatureSensorType]) -> [Sensor] {
        let currentCpu = CurrentDevice.getCpu()
        return Sensors.getSensors(sensorTypes, for: currentCpu)
    }
}
