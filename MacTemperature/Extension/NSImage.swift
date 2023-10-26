//
//  NSImage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 24.10.2023.
//

import Cocoa

extension NSImage {
    
    // TemperatureLevel icons
    static let temperatureLevelIconLow: NSImage = NSImage(systemSymbolName: "thermometer.low")!
    static let temperatureLevelIconMedium: NSImage = NSImage(systemSymbolName: "thermometer.medium")!
    static let temperatureLevelIconHigh: NSImage = NSImage(systemSymbolName: "thermometer.high")!

    // Settings icons
    static let settingsIconGeneral: NSImage = NSImage(systemSymbolName: "gearshape")!
    static let settingsIconMenuBar: NSImage = NSImage(systemSymbolName: "menubar.rectangle")!
    static let settingsIconStatusBar: NSImage = NSImage(systemSymbolName: "thermometer.medium")!
    
    convenience init?(systemSymbolName: String) {
        self.init(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
    }
}
