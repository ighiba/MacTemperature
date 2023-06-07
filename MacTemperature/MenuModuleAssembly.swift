//
//  MenuModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

class MenuModuleAssembly {
    class func configureModule() -> NSMenu {
        let menuPresenter = MenuPresenter()
        let menuBarView = MenuView()
        menuBarView.output = menuPresenter
        menuPresenter.input = menuBarView

        menuBarView.configureMenu(MenuBarSettingsData.shared)
        
        return menuBarView
    }
}
