//
//  MenuModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

class MenuModuleAssembly {
    class func configureModule() -> NSMenu {
        let view = MenuView()
        
        let sensorsManager = SensorsManagerImpl()
        let viewModel = MenuViewModel(menuBarSettings: MenuBarSettingsData.shared, sensorsManager: sensorsManager)
        
        view.viewModel = viewModel
        
        return view
    }
}
