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
        if floatValue >= 51.0 {
            return .high
        } else if floatValue >= 50.0 {
            return .medium
        } else {
            return .low
        }
//        if floatValue >= 99.0 {
//            return .high
//        } else if floatValue >= 65.0 {
//            return .medium
//        } else {
//            return .low
//        }
    }
}

