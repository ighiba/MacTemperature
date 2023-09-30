//
//  StatusBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

final class StatusBarSettingsData: Storable {
    
    static var storageKey: String { "statusBarSettings" }

    static let shared = StatusBarSettingsData()

    var statusBarShowIcon: Bool
    var statusBarAverageTemperatureFor: TemperatureSensorType
    
    init(statusBarShowIcon: Bool, statusBarAverageTemperatureFor: TemperatureSensorType) {
        self.statusBarShowIcon = statusBarShowIcon
        self.statusBarAverageTemperatureFor = statusBarAverageTemperatureFor
    }
    
    convenience init() {
        self.init(statusBarShowIcon: true, statusBarAverageTemperatureFor: .cpu)
    }
    
    static func getDefault() -> StatusBarSettingsData {
        return StatusBarSettingsData()
    }
    
    func set(_ data: StatusBarSettingsData) {
        statusBarShowIcon = data.statusBarShowIcon
        statusBarAverageTemperatureFor = data.statusBarAverageTemperatureFor
    }
}
