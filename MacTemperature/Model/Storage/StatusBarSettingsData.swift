//
//  StatusBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class StatusBarSettingsData: SettingsData {
    static var storageKey: String {
        return "statusBarSettings"
    }

    static let shared = StatusBarSettingsData()

    var statusBarShowIcon: Bool
    var statusBarAverageTemperatureFor: TemperatureSensorType
    
    init(statusBarShowIcon: Bool, statusBarAverageTemperatureFor: TemperatureSensorType) {
        self.statusBarShowIcon = statusBarShowIcon
        self.statusBarAverageTemperatureFor = statusBarAverageTemperatureFor
    }
    
    init() {
        self.statusBarShowIcon = true
        self.statusBarAverageTemperatureFor = .cpu
    }
    
    static func getDefaultSettings() -> StatusBarSettingsData {
        return StatusBarSettingsData()
    }
    
    func setSettings(_ settings: StatusBarSettingsData) {
        self.statusBarShowIcon = settings.statusBarShowIcon
        self.statusBarAverageTemperatureFor = settings.statusBarAverageTemperatureFor
    }
}
