//
//  Temperature.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 18.09.2024.
//

struct Temperature {
    var value: Float
    var level: Level { .getLevel(value) }
    
    enum Level {
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
    
    func getStringValue(scale: UInt8 = 1) -> String {
        return String(format: "%.\(scale)f", value)
    }
}

extension Temperature: ExpressibleByFloatLiteral {
    typealias FloatLiteralType = Float
    
    init(floatLiteral value: Float) {
        self.value = value
    }
}
