//
//  SettingsViewModel.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Foundation
import AppKit

protocol SettingsViewModelDelegate: AnyObject {
    var generalSettings: GeneralSettingsData { get }
    var menuBarSettings: MenuBarSettingsData { get }
    var statusBarSettings: StatusBarSettingsData { get }
    func setGeneralSettings(_ settings: GeneralSettingsData)
    func setMenuBarSettings(_ settings: MenuBarSettingsData)
    func setStatusBarSettings(_ settings: StatusBarSettingsData)
}

class SettingsViewModel: SettingsViewModelDelegate {
    
    var generalSettings: GeneralSettingsData { GeneralSettingsData.shared }
    var menuBarSettings: MenuBarSettingsData { MenuBarSettingsData.shared }
    var statusBarSettings: StatusBarSettingsData { StatusBarSettingsData.shared }
    
    var settingsStorage: SettingsStorage!
    
    func setGeneralSettings(_ settings: GeneralSettingsData) {
        generalSettings.set(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .updateFrequencyChangeNotification, object: settings.updateFrequencyInSeconds)
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.setAppToLaunchAtMacStart(state: settings.appShouldLaunchAfterStart)
    }

    func setMenuBarSettings(_ settings: MenuBarSettingsData) {
        menuBarSettings.set(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .menuUpdateNotification, object: settings)
    }
    
    func setStatusBarSettings(_ settings: StatusBarSettingsData) {
        statusBarSettings.set(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .isStatusBarIconEnabledChangeNotification, object: settings.statusBarShowIcon)
        NotificationCenter.default.post(name: .averageTemperatureSensorChangeNotification, object: settings.statusBarAverageTemperatureFor)
    }
}
