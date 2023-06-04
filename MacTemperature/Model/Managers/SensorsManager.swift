//
//  SensorsManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

protocol SensorsManager: AnyObject {
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t]
    func getSensorsForCurrentDevice(where sensorTypes: [TemperatureSensorType]) -> [Sensor]
}

class SensorsManagerImpl: SensorsManager {
    
    init() {
        
    }
    
    func getValues(_ sensors: [Sensor]) -> [SMCVal_t] {
        guard !sensors.isEmpty else { return [] }
        return sensors.map({ SMCVal_t($0.key) })
    }
    
    private func getCurrentCpuGeneration() -> CPUGeneration {
        guard let modelID = CurrentDevice.getModelIdentifier() else { return .unknown }
        let device = UserDevice(modelID: modelID, processorCount: ProcessInfo.processInfo.processorCount)
        return device.cpu.generation
    }
    
    func getSensorsForCurrentDevice(where sensorTypes: [TemperatureSensorType]) -> [Sensor] {
        let currentCpuGeneration = getCurrentCpuGeneration()
        return Sensors.getSensors(sensorTypes, for: currentCpuGeneration)
    }
    

}
