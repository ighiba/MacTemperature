//
//  SettingsModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsModuleAssembly {
    class func configureModule() -> NSViewController {
        let settingsStorage = SettingsStorage()
        let viewModel = SettingsViewModel(settingsStorage: settingsStorage)

        return SettingsViewControler(viewModel: viewModel)
    }
}
