//
//  StatusBarManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation
import AppKit

@objc protocol StatusBarDelegate: AnyObject {
    func enableIconSwitched(sender: NSSwitch)
}

class StatusBarManager {
    static let shared = StatusBarManager()
    
    private let statusItem: NSStatusItem
    private var isIconEnabled = true
    private var currentLevel: TemperatureLevel = .low
    
    var menu = NSMenu()
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        self.statusItem.button?.target = self
        self.statusItem.button?.action = #selector(statusBarButtonClicked)
        
        let menuItem1 = NSMenuItem(title: "Enable icon", action: #selector(statusBarButtonClicked), keyEquivalent: "")
        let menuItem2 = NSMenuItem(title: "CPU Temp", action: #selector(statusBarButtonClicked), keyEquivalent: "")
        menuItem1.view = EnableIconMenuItem(self)
        //menuItem2.view = CpuTempMenuView()
        
        
        menu.addItem(menuItem1)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(menuItem2)
        //menu.addItem(menuItem2)
        
        
        statusItem.menu = menu
    }

    func updateTemperature(_ floatValue: Float) {
        let stringValue = String(format: "%.0f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        self.currentLevel = TemperatureLevel.getLevel(floatValue)

        let attributedTitle = NSMutableAttributedString(string: newTitle)
        let attributesValue: [NSAttributedString.Key: Any] = [.foregroundColor: currentLevel.getColor()]
        let attributesC: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor.labelColor]
        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: abs(2 - newTitle.count))
        attributedTitle.addAttributes(attributesValue, range: rangeToPaintValue)
        attributedTitle.addAttributes(attributesC, range: rangeToPaintC)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
            button.image = isIconEnabled ? currentLevel.getImage() : nil
        }
    }
    
    func updateTitle(_ title: String) {
        if let button = self.statusItem.button {
            button.title = title
            button.contentTintColor = NSColor.systemTeal
        }
    }
}

extension StatusBarManager: StatusBarDelegate {
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        self.statusItem.menu?.popUp(positioning: nil, at: NSPoint(), in: statusItem.button)
    }
    
    @objc func enableIconSwitched(sender: NSSwitch) {
        isIconEnabled = sender.state == .on
        if let button = statusItem.button {
            button.image = isIconEnabled ? currentLevel.getImage() : nil
        }
    }
    
}
