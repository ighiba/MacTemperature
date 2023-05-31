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
        presenter.sensorsManager = SensorsManagerImpl()
        
        StatusBarManager.shared.temperatureManager = TemperatureManagerImpl()
        
        TemperatureMonitor.shared.temperatureManager = TemperatureManagerImpl()
        TemperatureMonitor.shared.sensorsManager = SensorsManagerImpl()
        TemperatureMonitor.shared.start()

        return view
    }
}
