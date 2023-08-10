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
        
        GeneralSettingsData.shared.setData(generalSettings)
        MenuBarSettingsData.shared.setData(menuBarSettings)
        StatusBarSettingsData.shared.setData(statusBarSettings)
    }
    
    class func saveAllSharedSettings() {
        let settingsStorage = SettingsStorage()
        settingsStorage.saveData(GeneralSettingsData.shared)
        settingsStorage.saveData(MenuBarSettingsData.shared)
        settingsStorage.saveData(StatusBarSettingsData.shared)
    }
}
