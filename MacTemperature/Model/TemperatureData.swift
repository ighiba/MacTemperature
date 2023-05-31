//
//  TemperatureData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

struct TemperatureData: Identifiable {
    
    let id: String
    var title: String
    var floatValue: Float
    var stringValue: String {
        return getStringValue()
    }
    
    init(id: String, title: String, floatValue: Float) {
        self.id = id
        self.title = title
        self.floatValue = floatValue
    }
    
    init(smcValue: SMCVal_t) {
        self.id = smcValue.key
        self.title = Sensor(rawValue: smcValue.key)?.title ?? "Unknown"
        self.floatValue = Float(smcValue.bytes) ?? 0.0
    }
    
    func getStringValue(scale: UInt8 = 1) -> String {
        return String(format: "%.\(scale)f", floatValue)
    }
}


