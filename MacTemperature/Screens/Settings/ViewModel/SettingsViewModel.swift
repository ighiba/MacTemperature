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
        generalSettings.setData(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .temperatureUpdateNotifaction, object: settings.updateFrequencyInSeconds)
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.setAppToLaunchAtMacStart(state: settings.appShouldLaunchAfterStart)
    }

    func setMenuBarSettings(_ settings: MenuBarSettingsData) {
        menuBarSettings.setData(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .menuUpdateNotification, object: settings)
    }
    
    func setStatusBarSettings(_ settings: StatusBarSettingsData) {
        statusBarSettings.setData(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: .isEnableStatusBarIconNotification, object: settings.statusBarShowIcon)
        NotificationCenter.default.post(name: .avgTemperatureTypeChangedNotification, object: settings.statusBarAverageTemperatureFor)
    }
}
