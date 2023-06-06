//
//  StatusBarManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation
import AppKit

let statusBarMenuWidth: CGFloat = 220

protocol StatusBarDelegate: AnyObject {
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData]
}

class StatusBarManager {
    static let shared = StatusBarManager()
    
    private let statusItem: NSStatusItem
    private var isIconEnabled = true
    private var avgTempType: TemperatureSensorType = .cpu
    private var avgTempValue: Float = 0.0
    private var avgTempCurrentLevel: TemperatureLevel {
        return TemperatureLevel.getLevel(avgTempValue)
    }
    
    var temperatureManager: TemperatureManager!
    
    var cpuTempView: TemperaturesMenuView!
    var gpuTempView: TemperaturesMenuView!
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        self.statusItem.button?.target = self
        self.statusItem.button?.action = #selector(statusBarButtonClicked)
        self.isStatusBarIconEnabled(state: StatusBarSettingsData.shared.statusBarShowIcon)
        
        self.cpuTempView = TemperaturesMenuView(title: "CPU Temperatures", type: .cpu, self)
        self.gpuTempView = TemperaturesMenuView(title: "GPU Temperatures", type: .gpu, self)
        
        statusItem.menu = configureMenu(MenuBarSettingsData.shared)
        
        NotificationCenter.default.addObserver(forName: NotificationNames.temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let tempMonitorData = notification.object as? TemperatureMonitorData, let strongSelf = self else { return }
            DispatchQueue.main.async {
                
                let cpuData = tempMonitorData[.cpu] ?? []
                strongSelf.cpuTempView?.updateRows(data: cpuData)
                
                let gpuData = tempMonitorData[.gpu] ?? []
                strongSelf.gpuTempView?.updateRows(data: gpuData)
                
                strongSelf.setAvgAndUpdateStatusBar(tempMonitorData, for: strongSelf.avgTempType)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.avgTemperatureTypeChangedNotification, object: nil, queue: nil) { [weak self] notification in
            guard let newAvgTempType = notification.object as? TemperatureSensorType, let strongSelf = self else { return }
            guard newAvgTempType != strongSelf.avgTempType else { return }
            
            strongSelf.avgTempType = newAvgTempType
            strongSelf.setAvgAndUpdateStatusBar(for: newAvgTempType)
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.isEnableStatusBarIconNotification, object: nil, queue: nil) { [weak self] notification in
            guard let statusBarShowIcon = notification.object as? Bool, let strongSelf = self else { return }
            strongSelf.isStatusBarIconEnabled(state: statusBarShowIcon)
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.menuUpdateNotification, object: nil, queue: nil) { [weak self] notification in
            guard let menuBarSettingsData = notification.object as? MenuBarSettingsData, let strongSelf = self else { return }
            strongSelf.statusItem.menu = nil
            strongSelf.statusItem.menu = strongSelf.configureMenu(menuBarSettingsData)
        }
    }
    
    private func setAvgAndUpdateStatusBar(_ data: TemperatureMonitorData? = nil, for type: TemperatureSensorType) {
        let tempMonitorData = data ?? TemperatureMonitor.lastData
        let tempDataForAvg = tempMonitorData[type] ?? []
        let avgTemp = self.temperatureManager.getAverageTemperatureFor(tempDataForAvg)
        self.avgTempValue = avgTemp
        self.updateStatusBarItemTitle(avgTemp)
    }

    private func updateStatusBarItemTitle(_ floatValue: Float? = nil) {
        let value = floatValue ?? self.avgTempValue
        let attributedTitle = getTemperatureAttributedString(value, colorProvider: avgTempCurrentLevel.getStatusBarColor)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
        }
    }
    
    func configureMenu(_ menuBarSettings: MenuBarSettingsData) -> NSMenu {
        let cpuTempItem = NSMenuItem(title: "CPU Temp", action: nil, keyEquivalent: "")
        let gpuTempItem = NSMenuItem(title: "GPU Temp", action: nil, keyEquivalent: "")
        let closeItem = NSMenuItem(title: "Close", action: #selector(closeButtonClicked), keyEquivalent: "q")
        let showWindowItem = NSMenuItem(title: "Show main window", action: #selector(showMainWindowClicked), keyEquivalent: "")
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(settingsClicked), keyEquivalent: ",")
        closeItem.target = self
        showWindowItem.target = self
        settingsItem.target = self
        
        cpuTempItem.view = self.cpuTempView
        gpuTempItem.view = self.gpuTempView
        
        let menu = NSMenu()
        
        if menuBarSettings.cpuShowTemperatures {
            menu.addItem(cpuTempItem)
            menu.addItem(NSMenuItem.separator())
        }
        
        if menuBarSettings.gpuShowTemperatures {
            menu.addItem(gpuTempItem)
            menu.addItem(NSMenuItem.separator())
        }
        
        menu.addItem(showWindowItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(settingsItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(closeItem)
        
        return menu
    }
    
    private func isStatusBarIconEnabled( state: Bool) {
        self.statusItem.button?.image = StatusBarSettingsData.shared.statusBarShowIcon ? avgTempCurrentLevel.getImage() : nil
    }
    
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        let level = TemperatureLevel.getLevel(floatValue)
        return getTemperatureAttributedString(floatValue, colorProvider: level.getStatusBarColor)
    }
    
    private func getTemperatureAttributedString(_ floatValue: Float,
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
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: 2)
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
    
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData] {
        let tempStatusData = TemperatureMonitor.lastData[type] ?? []
        return !tempStatusData.isEmpty ? tempStatusData : getSampleData(for: type)
    }
    
    private func getSampleData(for type: TemperatureSensorType) -> [TemperatureData] {
        let sensorsManager = SensorsManagerImpl()
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [type])
        let tempStatusData = sensors.map {
            TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0)
        }
        return tempStatusData
    }
}

extension NSMutableAttributedString {
    func addColorAttribute(_ color: NSColor, range: NSRange) {
        let colorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        self.addAttributes(colorAttribute, range: range)
    }
}

