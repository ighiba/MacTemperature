//
//  SettingsModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsModuleAssembly {
    class func configureModule() -> NSViewController {
        let view = SettingsViewControler()
        let presenter = SettingsPresenter()
        let storage = SettingsStorage()
        
        view.output = presenter
        presenter.input = view
        presenter.settingsStorage = storage
        
        return view
    }
}
