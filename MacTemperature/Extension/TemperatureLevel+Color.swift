//
//  TemperatureLevel+Color.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa
import SwiftUI

extension Temperature.Level {
    func getStatusBarColor() -> NSColor {
        switch self {
        case .low:
            return .labelColor
        case .medium:
            return .systemOrange
        case .high:
            return .systemRed
        }
    }
    
    func getMenuItemColor() -> NSColor {
        switch self {
        case .low:
            return .labelColor
        case .medium:
            return NSColor(named: "LevelColorMedium")!
        case .high:
            return .systemRed
        }
    }
    
    func getBarColor() -> Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}
