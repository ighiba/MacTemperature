//
//  TemperatureLevel+NSColor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

extension TemperatureLevel {
    func getColor() -> NSColor {
        switch self {
        case .low:    return NSColor.labelColor
        case .medium: return NSColor.systemOrange
        case .high:   return NSColor.systemRed
        }
    }
}
