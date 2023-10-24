//
//  NSImage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 24.10.2023.
//

import Cocoa

extension NSImage {

    static let settingsIconGeneral: NSImage = NSImage(systemSymbolName: "gearshape")!
    static let settingsIconMenuBar: NSImage = NSImage(systemSymbolName: "menubar.rectangle")!
    static let settingsIconStatusBar: NSImage = NSImage(systemSymbolName: "thermometer.medium")!
    
    convenience init?(systemSymbolName: String) {
        self.init(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
    }
}
