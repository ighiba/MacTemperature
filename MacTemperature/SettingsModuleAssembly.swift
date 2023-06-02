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
        
        view.output = presenter
        presenter.input = view
        
        return view
    }
}
