//
//  TemperatureLevel+NSImage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

extension TemperatureLevel {
    func getIcon() -> NSImage {
        switch self {
        case .low:
            return .temperatureLevelIconLow
        case .medium:
            return .temperatureLevelIconMedium
        case .high:
            return .temperatureLevelIconHigh
        }
    }
}
