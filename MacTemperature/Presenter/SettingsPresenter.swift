//
//  SettingsPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Foundation
import AppKit

protocol SettingsInput: AnyObject {

//    func getMenuBarSettings() -> MenuBarSettingsData
//    func getStatusBarSettings() -> StatusBarSettingsData
    //func setGeneralSettings(_ settings: GeneralSettingsData)
}

protocol SettingsOutput: AnyObject {
    func getGeneralSettings() -> GeneralSettingsData
    func setGeneralSettings(_ settings: GeneralSettingsData)
    func getMenuBarSettings() -> MenuBarSettingsData
    func setMenuBarSettings(_ settings: MenuBarSettingsData)
    func getStatusBarSettings() -> StatusBarSettingsData
    func setStatusBarSettings(_ settings: StatusBarSettingsData)
}

class SettingsPresenter: SettingsOutput {
    
    weak var input: SettingsInput!
    
    var settingsStorage: SettingsStorage!

    init() {
        
    }
    
    func getGeneralSettings() -> GeneralSettingsData {
        return GeneralSettingsData.shared
    }
    
    func setGeneralSettings(_ settings: GeneralSettingsData) {
        GeneralSettingsData.shared.setSettings(settings)
        settingsStorage.saveData(settings)
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.setAppToLaunchAtMacStart(state: settings.appShouldLaunchAfterStart)
    }
    
    func getMenuBarSettings() -> MenuBarSettingsData {
        return MenuBarSettingsData.shared
    }
    
    func setMenuBarSettings(_ settings: MenuBarSettingsData) {
        MenuBarSettingsData.shared.setSettings(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: NotificationNames.menuUpdateNotification, object: settings)
    }
    
    func getStatusBarSettings() -> StatusBarSettingsData {
        return StatusBarSettingsData.shared
    }
    
    func setStatusBarSettings(_ settings: StatusBarSettingsData) {
        StatusBarSettingsData.shared.setSettings(settings)
        settingsStorage.saveData(settings)
        NotificationCenter.default.post(name: NotificationNames.isEnableStatusBarIconNotification, object: settings.statusBarShowIcon)
    }

}
