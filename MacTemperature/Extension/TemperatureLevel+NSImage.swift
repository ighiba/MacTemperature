//
//  TemperatureLevel+NSImage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

extension TemperatureLevel {
    func getImage() -> NSImage {
        switch self {
        case .low:
            return NSImage(systemSymbolName: "thermometer.low", accessibilityDescription: nil)!
        case .medium:
            return NSImage(systemSymbolName: "thermometer.medium", accessibilityDescription: nil)!
        case .high:
            return NSImage(systemSymbolName: "thermometer.high", accessibilityDescription: nil)!
        }
    }
}
