//
//  TemperatureLevel.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

enum TemperatureLevel {
    case low
    case medium
    case high
    
    static func getLevel(_ floatValue: Float) -> Self {
        if floatValue >= 99.9 {
            return .high
        } else if floatValue >= 64.9 {
            return .medium
        } else {
            return .low
        }
    }
}
