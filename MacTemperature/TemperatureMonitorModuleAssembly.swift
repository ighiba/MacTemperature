//
//  TemperatureMonitorModuleAssembly.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 01.06.2023.
//

import Foundation

class TemperatureMonitorModuleAssembly {
    class func configureModule() {
        TemperatureMonitor.shared.temperatureManager = TemperatureManagerImpl()
        TemperatureMonitor.shared.sensorsManager = SensorsManagerImpl()
        TemperatureMonitor.shared.start()
    }
}
