//
//  StatusBarManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation
import AppKit

class StatusBarManager {
    static let shared = StatusBarManager()
    
    private let statusItem: NSStatusItem
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    }
    
    func updateTemperature(_ floatValue: Float) {
        let stringValue = String(format: "%.0f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        let currentLevel = TemperatureLevel.getLevel(floatValue)

        let attributedTitle = NSMutableAttributedString(string: newTitle)
        let attributesValue: [NSAttributedString.Key: Any] = [.foregroundColor: currentLevel.getColor()]
        let attributesC: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor.labelColor]
        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: abs(2 - newTitle.count))
        attributedTitle.addAttributes(attributesValue, range: rangeToPaintValue)
        attributedTitle.addAttributes(attributesC, range: rangeToPaintC)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
            button.image = currentLevel.getImage()
        }
    }
    
    func updateTitle(_ title: String) {
        if let button = self.statusItem.button {
            button.title = title
            button.contentTintColor = NSColor.systemTeal
        }
    }
}
