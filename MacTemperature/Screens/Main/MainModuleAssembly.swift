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
        let view = MainViewController()
        let viewModel = MainViewModel()
        
        view.viewModel = viewModel
        
        viewModel.sensorsManager = SensorsManagerImpl()

        return view
    }
}
