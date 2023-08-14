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
        case .low:    return .labelColor
        case .medium: return .systemOrange
        case .high:   return .systemRed
        }
    }
    
    func getBarColor() -> Color {
        switch self {
        case .low:    return .green
        case .medium: return .orange
        case .high:   return .red
        }
    }
}
