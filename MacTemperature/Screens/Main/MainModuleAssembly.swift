//
//  MainModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation
import Cocoa

class MainModuleAssembly {
    class func configureModule() -> NSViewController {
        let sensorsManager = SensorsManagerImpl()
        let viewModel = MainViewModel(sensorsManager: sensorsManager)

        return MainViewController(viewModel: viewModel)
    }
}
