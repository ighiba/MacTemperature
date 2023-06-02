//
//  GeneralSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class GeneralSettingsData: SettingsData {
    static var storageKey: String {
        return "generalSettings"
    }

    static let shared = GeneralSettingsData()
    
    var mainWindowOpenEveryLaunch: Bool
    var appShouldLaunchAfterStart: Bool
    var updateFrequencyInSeconds: Int
    
    init(mainWindowOpenEveryLaunch: Bool, appShouldLaunchAfterStart: Bool, updateFrequencyInSeconds: Int) {
        self.mainWindowOpenEveryLaunch = mainWindowOpenEveryLaunch
        self.appShouldLaunchAfterStart = appShouldLaunchAfterStart
        self.updateFrequencyInSeconds = updateFrequencyInSeconds
    }
    
    init() {
        self.mainWindowOpenEveryLaunch = true
        self.appShouldLaunchAfterStart = true
        self.updateFrequencyInSeconds = 1
    }
    
    static func getDefaultSettings() -> GeneralSettingsData {
        return GeneralSettingsData()
    }
}
