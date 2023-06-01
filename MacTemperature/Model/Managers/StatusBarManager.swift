//
//  StatusBarManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation
import AppKit

let statusBarMenuWidth: CGFloat = 220

@objc protocol StatusBarDelegate: AnyObject {
    func enableIconSwitched(sender: NSSwitch)
    func getDefaultTemperatuerAttributedString(_ floatValue: Float) -> NSMutableAttributedString
}

class StatusBarManager {
    static let shared = StatusBarManager()
    
    private let statusItem: NSStatusItem
    private var isIconEnabled = true
    private var statusBarFloatValue: Float = 0.0
    private var currentLevel: TemperatureLevel {
        return TemperatureLevel.getLevel(statusBarFloatValue)
    }
    
    var temperatureManager: TemperatureManager!
    
    var menu = NSMenu()
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        self.statusItem.button?.target = self
        self.statusItem.button?.action = #selector(statusBarButtonClicked)
        
        let enableIconItem = NSMenuItem(title: "Enable icon", action: nil, keyEquivalent: "")
        let cpuTempItem = NSMenuItem(title: "CPU Temp", action: nil, keyEquivalent: "")
        let closeItem = NSMenuItem(title: "Close", action: #selector(closeButtonClicked), keyEquivalent: "q")
        closeItem.target = self
        
        enableIconItem.view = EnableIconMenuItem(self)
        let cpuTempView = TemperaturesMenuView(title: "CPU Temperatures", self)
        cpuTempItem.view = cpuTempView
        
        menu.addItem(enableIconItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(cpuTempItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(closeItem)
        
        statusItem.menu = menu
        
        NotificationCenter.default.addObserver(forName: TemperatureMonitor.temperatureUpdateNotifaction, object: nil, queue: nil) { notification in
            guard let values = notification.object as? [SMCVal_t] else { return }
            DispatchQueue.main.async {
                let tempStatusData = values.map {
                    TemperatureData(smcValue: $0)
                }
                cpuTempView.updateRows(data: tempStatusData)
                
                let avgCPUTemp = self.temperatureManager.getAverageTemperatureFor(values)
                self.statusBarFloatValue = avgCPUTemp
                self.updateStatusBarItemTitle(avgCPUTemp)
            }
        }
    }

    func updateStatusBarItemTitle(_ floatValue: Float? = nil) {
        let value = floatValue ?? self.statusBarFloatValue
        let attributedTitle = geTemperatureAttributedString(value, colorHanler: currentLevel.getStatusBarColor)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
            button.image = isIconEnabled ? currentLevel.getImage() : nil
        }
    }
    
    func getDefaultTemperatuerAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        return geTemperatureAttributedString(floatValue, colorHanler: currentLevel.getStatusBarColor)
    }
    
    func geTemperatureAttributedString(_ floatValue: Float,
                                       scale: UInt8 = 0,
                                       colorHanler: (() -> NSColor)? = nil) -> NSMutableAttributedString {
        let stringValue = String(format: "%.\(scale)f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        let defaultlColorHandler: () -> NSColor = {
            return NSColor.labelColor
        }
        
        let getColor = colorHanler ?? defaultlColorHandler
        
        let attributedTitle = NSMutableAttributedString(string: newTitle)
        let attributesValue: [NSAttributedString.Key: Any] = [.foregroundColor: getColor()]
        let attributesC: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor.labelColor]
        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: abs(2 - newTitle.count))
        attributedTitle.addAttributes(attributesValue, range: rangeToPaintValue)
        attributedTitle.addAttributes(attributesC, range: rangeToPaintC)
        
        return attributedTitle
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
    
    @objc func closeButtonClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(nil)
    }
}
