//
//  Sensors.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

struct Sensor {
    var key: String
    var title: String
    var type: TemperatureSensorType
    var cpuGeneration: CPUGeneration
}

struct Sensors {
    
    static let listAll = [
        Sensor(key: "Tp09", title: "CPU Efficiency core 1", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0T", title: "CPU Efficiency core 2", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp01", title: "CPU Performance core 1", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp05", title: "CPU Performance core 2", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0D", title: "CPU Performance core 3", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0H", title: "CPU Performance core 4", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0L", title: "CPU Performance core 5", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0P", title: "CPU Performance core 6", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0X", title: "CPU Performance core 7", type: .cpu, cpuGeneration: .M1),
        Sensor(key: "Tp0b", title: "CPU Performance core 8", type: .cpu, cpuGeneration: .M1),
        
        Sensor(key: "Tg05", title: "GPU Cluster 1", type: .gpu, cpuGeneration: .M1),
        Sensor(key: "Tg0D", title: "GPU Cluster 2", type: .gpu, cpuGeneration: .M1),
        Sensor(key: "Tg0L", title: "GPU Cluster 3", type: .gpu, cpuGeneration: .M1),
        Sensor(key: "Tg0T", title: "GPU Cluster 4", type: .gpu, cpuGeneration: .M1),
        
        Sensor(key: "Tp05", title: "CPU Efficiency core 1", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp0D", title: "CPU Efficiency core 2", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp0j", title: "CPU Efficiency core 3", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp0r", title: "CPU Efficiency core 4", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp01", title: "CPU Performance core 1", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp09", title: "CPU Performance core 2", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp0f", title: "CPU Performance core 3", type: .cpu, cpuGeneration: .M2),
        Sensor(key: "Tp0n", title: "CPU Performance core 4", type: .cpu, cpuGeneration: .M2),
        
        Sensor(key: "Tg0f", title: "GPU Cluster 1", type: .gpu, cpuGeneration: .M2),
        Sensor(key: "Tg0n", title: "GPU Cluster 2", type: .gpu, cpuGeneration: .M2),
    ]
    
    static func getSensors(_ types: [TemperatureSensorType], for generation: CPUGeneration) -> [Sensor] {
        return Sensors.listAll.filter { $0.cpuGeneration == generation && types.contains($0.type) }
    }
    
}


