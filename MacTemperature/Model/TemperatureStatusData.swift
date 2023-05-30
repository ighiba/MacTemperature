//
//  TemperatureStatusData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

struct TemperatureStatusData {
    var key: String
    var title: String
    var floatValue: Float
    
    init(key: String, title: String, floatValue: Float) {
        self.key = key
        self.title = title
        self.floatValue = floatValue
    }
    
    init(smcValue: SMCVal_t) {
        self.key = smcValue.key
        self.title = Sensor(rawValue: smcValue.key)?.title ?? "Unknown"
        self.floatValue = Float(smcValue.bytes) ?? 0.0
    }
}
