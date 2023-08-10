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
    private var isIconEnabled = true
    private var avgTempType: TemperatureSensorType = .cpu
    private var avgTempValue: Float = 0.0
    private var avgTempCurrentLevel: TemperatureLevel {
        return TemperatureLevel.getLevel(avgTempValue)
    }
    
    var temperatureManager: TemperatureManager!
    
    private init() {
        self.statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        self.statusItem.button?.target = self
        self.statusItem.button?.action = #selector(statusBarButtonClicked)
        self.isStatusBarIconEnabled(state: StatusBarSettingsData.shared.statusBarShowIcon)

        statusItem.menu = MenuModuleAssembly.configureModule()
        
        NotificationCenter.default.addObserver(forName: NotificationNames.temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let tempMonitorData = notification.object as? TemperatureMonitorData, let strongSelf = self else { return }
            DispatchQueue.main.async {
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
            guard let statusBarShowIcon = notification.object as? Bool else { return }
            self?.isStatusBarIconEnabled(state: statusBarShowIcon)
        }
        
        NotificationCenter.default.addObserver(forName: NotificationNames.menuUpdateNotification, object: nil, queue: nil) { [weak self] notification in
            self?.statusItem.menu = MenuModuleAssembly.configureModule()
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
        let attributedTitle = NSMutableAttributedString.formatTemperatureValue(value, colorProvider: avgTempCurrentLevel.getStatusBarColor)
        
        if let button = self.statusItem.button {
            button.attributedTitle = attributedTitle
        }
    }
    
    private func isStatusBarIconEnabled( state: Bool) {
        self.statusItem.button?.image = StatusBarSettingsData.shared.statusBarShowIcon ? avgTempCurrentLevel.getImage() : nil
    }
    
    func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        let level = TemperatureLevel.getLevel(floatValue)
        return NSMutableAttributedString.formatTemperatureValue(floatValue, colorProvider: level.getStatusBarColor)
    }
}

extension StatusBarManager {
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        self.statusItem.menu?.popUp(positioning: nil, at: NSPoint(), in: statusItem.button)
    }
}
