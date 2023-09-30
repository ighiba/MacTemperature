//
//  GeneralSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

final class GeneralSettingsData: Storable {

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
    
    convenience init() {
        self.init(mainWindowOpenEveryLaunch: true, appShouldLaunchAfterStart: true, updateFrequencyInSeconds: 1)
    }
    
    static func getDefault() -> GeneralSettingsData {
        return GeneralSettingsData()
    }
    
    func set(_ data: GeneralSettingsData) {
        mainWindowOpenEveryLaunch = data.mainWindowOpenEveryLaunch
        appShouldLaunchAfterStart = data.appShouldLaunchAfterStart
        updateFrequencyInSeconds = data.updateFrequencyInSeconds
    }
}
