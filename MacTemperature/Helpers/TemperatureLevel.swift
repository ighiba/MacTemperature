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
//        #if DEBUG
//        if floatValue >= 51.0 {
//            return .high
//        } else if floatValue >= 50.0 {
//            return .medium
//        } else {
//            return .low
//        }
//        #endif
        if floatValue >= 99.9 {
            return .high
        } else if floatValue >= 64.9 {
            return .medium
        } else {
            return .low
        }
    }
}

