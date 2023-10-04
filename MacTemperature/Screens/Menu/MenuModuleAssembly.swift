//
//  MenuModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

class MenuModuleAssembly {
    class func configureModule() -> NSMenu {
        let sensorsManager = SensorsManagerImpl()
        let viewModel = MenuViewModel(menuBarSettings: MenuBarSettingsData.shared, sensorsManager: sensorsManager)

        return MenuView(viewModel: viewModel)
    }
}
