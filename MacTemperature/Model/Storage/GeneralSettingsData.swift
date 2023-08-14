//
//  GeneralSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class GeneralSettingsData: Storable {
    
    static var storageKey: String { "generalSettings" }

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
        mainWindowOpenEveryLaunch = true
        appShouldLaunchAfterStart = true
        updateFrequencyInSeconds = 1
    }
    
    static func getDefaultData() -> GeneralSettingsData {
        return GeneralSettingsData()
    }
    
    func setData(_ settings: GeneralSettingsData) {
        mainWindowOpenEveryLaunch = settings.mainWindowOpenEveryLaunch
        appShouldLaunchAfterStart = settings.appShouldLaunchAfterStart
        updateFrequencyInSeconds = settings.updateFrequencyInSeconds
    }
}
