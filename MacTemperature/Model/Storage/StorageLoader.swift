//
//  StorageLoader.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class StorageLoader {
    class func loadAllSharedSettings() {
        let settingsStorage = SettingsStorage()
        let generalSettings: GeneralSettingsData = settingsStorage.loadData()
        let menuBarSettings: MenuBarSettingsData = settingsStorage.loadData()
        let statusBarSettings: StatusBarSettingsData = settingsStorage.loadData()
        
        GeneralSettingsData.shared.set(generalSettings)
        MenuBarSettingsData.shared.set(menuBarSettings)
        StatusBarSettingsData.shared.set(statusBarSettings)
    }
    
    class func saveAllSharedSettings() {
        let settingsStorage = SettingsStorage()
        settingsStorage.saveData(GeneralSettingsData.shared)
        settingsStorage.saveData(MenuBarSettingsData.shared)
        settingsStorage.saveData(StatusBarSettingsData.shared)
    }
}
