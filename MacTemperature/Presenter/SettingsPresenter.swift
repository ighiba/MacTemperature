//
//  SettingsPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Foundation

protocol SettingsInput: AnyObject {

//    func getMenuBarSettings() -> MenuBarSettingsData
//    func getStatusBarSettings() -> StatusBarSettingsData
    //func setGeneralSettings(_ settings: GeneralSettingsData)
}

protocol SettingsOutput: AnyObject {
    func getGeneralSettings() -> GeneralSettingsData
    func setGeneralSettings(_ settings: GeneralSettingsData)

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
    }

}
