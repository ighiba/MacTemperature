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
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString
}

class StatusBarManager {
    static let shared = StatusBarManager()
    
    private let statusItem: NSStatusItem
    private var isIconEnabled = true
    private var avgTempValue: Float = 0.0
    private var avgTempCurrentLevel: TemperatureLevel {
        return TemperatureLevel.getLevel(avgTempValue)
    }
    
    var temperatureManager: TemperatureManager!
    
    var menu = NSMenu()
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        self.statusItem.button?.target = self
        self.statusItem.button?.action = #selector(statusBarButtonClicked)
        self.isStatusBarIconEnabled(state: StatusBarSettingsData.shared.statusBarShowIcon)
        
        let cpuTempItem = NSMenuItem(title: "CPU Temp", action: nil, keyEquivalent: "")
        let closeItem = NSMenuItem(title: "Close", action: #selector(closeButtonClicked), keyEquivalent: "q")
        let showWindowItem = NSMenuItem(title: "Show main window", action: #selector(showMainWindowClicked), keyEquivalent: "")
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(settingsClicked), keyEquivalent: ",")
        closeItem.target = self
        showWindowItem.target = self
        settingsItem.target = self
        
        let cpuTempView = TemperaturesMenuView(title: "CPU Temperatures", self)
        cpuTempItem.view = cpuTempView
        
        menu.addItem(cpuTempItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(showWindowItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(settingsItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(closeItem)
        
        statusItem.menu = menu
        
        NotificationCenter.default.addObserver(forName: NotificationNames.temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let values = notification.object as? [SMCVal_t], let strongSelf = self else { return }
            DispatchQueue.main.async {
                let tempStatusData = values.map {
                    TemperatureData(smcValue: $0)
                }
                cpuTempView.updateRows(data: tempStatusData)
                
                let avgCPUTemp = strongSelf.temperatureManager.getAverageTemperatureFor(values)
                strongSelf.avgTempValue = avgCPUTemp
                strongSelf.updateStatusBarItemTitle(avgCPUTemp)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.isEnableStatusBarIconNotification, object: nil, queue: nil) { [weak self] notification in
            guard let statusBarShowIcon = notification.object as? Bool, let strongSelf = self else { return }
            strongSelf.isStatusBarIconEnabled(state: statusBarShowIcon)
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.menuUpdateNotification, object: nil, queue: nil) { [weak self] notification in
            guard let menuBarSettingsData = notification.object as? MenuBarSettingsData, let strongSelf = self else { return }
            
            if menuBarSettingsData.cpuShowTemperatures {
                strongSelf.menu.insertItem(cpuTempItem, at: 0)
            } else {
                strongSelf.menu.removeItem(cpuTempItem)
            }
            
//            if menuBarSettingsData.gpuShowTemperatures {
//                strongSelf.menu.insertItem(gpuTempItem, at: 1)
//            } else {
//                strongSelf.menu.removeItem(gpuTempItem)
//            }
        }
    }

    func updateStatusBarItemTitle(_ floatValue: Float? = nil) {
        let value = floatValue ?? self.avgTempValue
        let attributedTitle = getTemperatureAttributedString(value, colorProvider: avgTempCurrentLevel.getStatusBarColor)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
        }
    }
    
    private func isStatusBarIconEnabled( state: Bool) {
        self.statusItem.button?.image = StatusBarSettingsData.shared.statusBarShowIcon ? avgTempCurrentLevel.getImage() : nil
    }
    
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        let level = TemperatureLevel.getLevel(floatValue)
        return getTemperatureAttributedString(floatValue, colorProvider: level.getStatusBarColor)
    }
    
    func getTemperatureAttributedString(_ floatValue: Float,
                                       scale: UInt8 = 0,
                                       colorProvider: (() -> NSColor)? = nil) -> NSMutableAttributedString {
        let stringValue = String(format: "%.\(scale)f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        let defaultlColorProvider: () -> NSColor = {
            return NSColor.labelColor
        }
        
        let getColor = colorProvider ?? defaultlColorProvider
        
        let attributedTitle = NSMutableAttributedString(string: newTitle)

        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: abs(2 - newTitle.count))
        attributedTitle.addColorAttribute(getColor(), range: rangeToPaintValue)
        attributedTitle.addColorAttribute(NSColor.labelColor, range: rangeToPaintC)
        
        return attributedTitle
    }
}

extension StatusBarManager: StatusBarDelegate {
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        self.statusItem.menu?.popUp(positioning: nil, at: NSPoint(), in: statusItem.button)
    }
    
    @objc func closeButtonClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(nil)
    }
    
    @objc func showMainWindowClicked(_ sender: NSMenuItem) {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.showMainWindow()
    }
    
    @objc func settingsClicked(_ sender: NSMenuItem) {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.showSettingsWindow()
    }
}

extension NSMutableAttributedString {
    func addColorAttribute(_ color: NSColor, range: NSRange) {
        let colorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        self.addAttributes(colorAttribute, range: range)
    }
}

