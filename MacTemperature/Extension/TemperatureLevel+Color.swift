//
//  TemperatureLevel+Color.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa
import SwiftUI

extension TemperatureLevel {
    
    func getStatusBarColor() -> NSColor {
        switch self {
        case .low:    return NSColor.labelColor
        case .medium: return NSColor.systemOrange
        case .high:   return NSColor.systemRed
        }
    }
    
    func getBarColor() -> Color {
        switch self {
        case .low:    return Color.green
        case .medium: return Color.orange
        case .high:   return Color.red
        }
    }
}
