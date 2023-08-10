//
//  MenuBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class MenuBarSettingsData: Storable {
    static var storageKey: String { "menuBarSettings" }

    static let shared = MenuBarSettingsData()
    
    var cpuShowTemperatures: Bool
    var gpuShowTemperatures: Bool
    
    init(cpuShowTemperatures: Bool, gpuShowTemperatures: Bool) {
        self.cpuShowTemperatures = cpuShowTemperatures
        self.gpuShowTemperatures = gpuShowTemperatures
    }
    
    init() {
        cpuShowTemperatures = true
        gpuShowTemperatures = false
    }
    
    static func getDefaultData() -> MenuBarSettingsData {
        return MenuBarSettingsData()
    }
    
    func setData(_ settings: MenuBarSettingsData) {
        cpuShowTemperatures = settings.cpuShowTemperatures
        gpuShowTemperatures = settings.gpuShowTemperatures
    }
}
