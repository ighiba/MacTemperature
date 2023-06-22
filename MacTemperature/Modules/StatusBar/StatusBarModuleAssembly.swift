//
//  StatusBarModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 01.06.2023.
//

import Foundation

class StatusBarModuleAssembly {
    class func configureModule() {
        StatusBarManager.shared.temperatureManager = TemperatureManagerImpl()
    }
}
