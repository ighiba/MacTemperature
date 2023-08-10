//
//  MenuModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

class MenuModuleAssembly {
    class func configureModule() -> NSMenu {
        let menuBarView = MenuView()
        let menuViewModel = MenuViewModel(menuBarSettings: MenuBarSettingsData.shared)
        
        menuBarView.viewModel = menuViewModel
        
        return menuBarView
    }
}
