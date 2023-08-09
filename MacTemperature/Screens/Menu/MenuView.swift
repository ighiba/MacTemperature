//
//  MenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

let statusBarMenuWidth: CGFloat = 220

protocol MenuInput: AnyObject {
    var cpuTempView: TemperaturesMenuView! { get set }
    var gpuTempView: TemperaturesMenuView! { get set }
    func updateCpuRows(data: [TemperatureData])
    func updateGpuRows(data: [TemperatureData])
}

protocol MenuViewDelegate: AnyObject {
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData]
}

class MenuView: NSMenu, MenuInput, MenuViewDelegate {
        
    var cpuTempView: TemperaturesMenuView!
    var gpuTempView: TemperaturesMenuView!
    
    var output: MenuOutput!
    
    func configureMenu(_ menuBarSettings: MenuBarSettingsData) {
        let cpuTempItem = NSMenuItem(title: "CPU Temp", action: nil, keyEquivalent: "")
        let gpuTempItem = NSMenuItem(title: "GPU Temp", action: nil, keyEquivalent: "")
        let closeItem = NSMenuItem(title: "Close", action: #selector(closeButtonClicked), keyEquivalent: "q")
        let showWindowItem = NSMenuItem(title: "Show main window", action: #selector(showMainWindowClicked), keyEquivalent: "")
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(settingsClicked), keyEquivalent: ",")
        closeItem.target = self
        showWindowItem.target = self
        settingsItem.target = self
        
        self.cpuTempView = TemperaturesMenuView(title: "CPU Temperatures", type: .cpu, self)
        self.gpuTempView = TemperaturesMenuView(title: "GPU Temperatures", type: .gpu, self)
        
        cpuTempItem.view = self.cpuTempView
        gpuTempItem.view = self.gpuTempView
        
        
        if menuBarSettings.cpuShowTemperatures {
            self.addItem(cpuTempItem)
            self.addItem(NSMenuItem.separator())
        }
        
        if menuBarSettings.gpuShowTemperatures {
            self.addItem(gpuTempItem)
            self.addItem(NSMenuItem.separator())
        }
        
        self.addItem(showWindowItem)
        self.addItem(NSMenuItem.separator())
        self.addItem(settingsItem)
        self.addItem(NSMenuItem.separator())
        self.addItem(closeItem)
    }
    
    func loadInitialData(for type: TemperatureSensorType) -> [TemperatureData] {
        output.loadInitialData(for: type)
    }
    
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        let level = TemperatureLevel.getLevel(floatValue)
        return NSMutableAttributedString.formatTemperatureValue(floatValue, colorProvider: level.getStatusBarColor)
    }
    
    func updateCpuRows(data: [TemperatureData]) {
        self.cpuTempView?.updateRows(data: data)
    }
    
    func updateGpuRows(data: [TemperatureData]) {
        self.gpuTempView?.updateRows(data: data)
    }
    
    @objc func closeButtonClicked(_ sender: NSMenuItem) {
        output.terminateApplication()
    }
    
    @objc func showMainWindowClicked(_ sender: NSMenuItem) {
        output.showMainWindow()
    }
    
    @objc func settingsClicked(_ sender: NSMenuItem) {
        output.showSettingsWindow()
    }
}
