//
//  MainModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation
import Cocoa

class MainModuleAssembly {
    
    class func configureMoule() -> NSViewController {
        let presenter = MainPresenter()
        let view = MainViewController()
        
        view.output = presenter
        presenter.input = view
        presenter.temperatureManager = TemperatureManagerImpl()
        
        return view
    }
}
