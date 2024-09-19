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

    private var isThermometerIconEnabled: Bool = false {
        didSet {
            reloadStatusBar()
        }
    }
    private var averageTemperatureSensor: TemperatureSensorType = .cpu {
        didSet {
            reloadStatusBar()
        }
    }
    
    private let statusItem: NSStatusItem
    
    private init() {
        statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        statusItem.button?.action = #selector(statusBarButtonClicked)
        statusItem.button?.target = self

        statusItem.menu = MenuModuleAssembly.configureModule()
        
        loadSettings()
        addObservers()
    }
    
    private func loadSettings() {
        let settings = StatusBarSettingsData.shared
        isThermometerIconEnabled = settings.statusBarShowIcon
        averageTemperatureSensor = settings.statusBarAverageTemperatureFor
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: .temperatureMonitorUpdateNotification, object: nil, queue: nil) { [weak self] notification in
            guard let temperatureMonitorData = notification.object as? TemperatureMonitorData else { return }
            
            DispatchQueue.main.async {
                self?.temperatureMonitorDataDidUpdate(temperatureMonitorData)
            }
        }
        
        NotificationCenter.default.addObserver(forName: .averageTemperatureSensorChangeNotification, object: nil, queue: nil) { [weak self] notification in
            guard let newAverageTemperatureSensor = notification.object as? TemperatureSensorType, newAverageTemperatureSensor != self?.averageTemperatureSensor else { return }
            
            self?.averageTemperatureSensor = newAverageTemperatureSensor
        }
        
        NotificationCenter.default.addObserver(forName: .isStatusBarIconEnabledChangeNotification, object: nil, queue: nil) { [weak self] notification in
            guard let isStatusBarIconEnabled = notification.object as? Bool else { return }
            
            self?.isThermometerIconEnabled = isStatusBarIconEnabled
        }
        
        NotificationCenter.default.addObserver(forName: .menuUpdateNotification, object: nil, queue: nil) { [weak self] notification in
            self?.statusItem.menu = MenuModuleAssembly.configureModule()
        }
    }
    
    private func reloadStatusBar() {
        temperatureMonitorDataDidUpdate(TemperatureMonitor.lastData)
    }

    private func temperatureMonitorDataDidUpdate(_ temperatureData: TemperatureMonitorData) {
        let temperatureDataForAverage = temperatureData[averageTemperatureSensor] ?? []
        let averageTemperature = temperatureDataForAverage.getAverageTemperature()
        
        updateTemperatureLabel(temperature: averageTemperature)
        updateThermometerIcon(temperature: averageTemperature)
    }

    private func updateTemperatureLabel(temperature: Temperature) {
        let attributedString = NSMutableAttributedString.makeTemperatureAttributedString(
            temperature.value,
            valueColor: temperature.level.getStatusBarColor()
        )
        guard attributedString.string != statusItem.button?.attributedTitle.string else { return }
        
        statusItem.button?.attributedTitle = attributedString
    }
    
    private func updateThermometerIcon(temperature: Temperature) {
        let newIcon: NSImage? = isThermometerIconEnabled ? temperature.level.getIcon() : nil
        guard newIcon != statusItem.button?.image else { return }
        
        statusItem.button?.image = newIcon
    }
}

extension StatusBarManager {
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        statusItem.menu?.popUp(positioning: nil, at: .zero, in: statusItem.button)
    }
}
