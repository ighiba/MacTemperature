//
//  StatusBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class StatusBarSettingsData: Storable {
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
    
    static func getDefaultData() -> StatusBarSettingsData {
        return StatusBarSettingsData()
    }
    
    func setData(_ settings: StatusBarSettingsData) {
        self.statusBarShowIcon = settings.statusBarShowIcon
        self.statusBarAverageTemperatureFor = settings.statusBarAverageTemperatureFor
    }
}
