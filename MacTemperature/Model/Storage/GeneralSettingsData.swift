//
//  GeneralSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class GeneralSettingsData: Storable {
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
    
    static func getDefaultData() -> GeneralSettingsData {
        return GeneralSettingsData()
    }
    
    func setData(_ settings: GeneralSettingsData) {
        self.mainWindowOpenEveryLaunch = settings.mainWindowOpenEveryLaunch
        self.appShouldLaunchAfterStart = settings.appShouldLaunchAfterStart
        self.updateFrequencyInSeconds = settings.updateFrequencyInSeconds
    }
}
