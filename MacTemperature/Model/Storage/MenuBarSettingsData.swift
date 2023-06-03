//
//  MenuBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

class MenuBarSettingsData: SettingsData {
    static var storageKey: String {
        return "menuBarSettings"
    }

    static let shared = MenuBarSettingsData()
    
    var cpuShowTemperatures: Bool
    var gpuShowTemperatures: Bool
    
    init(cpuShowTemperatures: Bool, gpuShowTemperatures: Bool) {
        self.cpuShowTemperatures = cpuShowTemperatures
        self.gpuShowTemperatures = gpuShowTemperatures
    }
    
    init() {
        self.cpuShowTemperatures = true
        self.gpuShowTemperatures = false
    }
    
    static func getDefaultSettings() -> MenuBarSettingsData {
        return MenuBarSettingsData()
    }
    
    func setSettings(_ settings: MenuBarSettingsData) {
        self.cpuShowTemperatures = settings.cpuShowTemperatures
        self.gpuShowTemperatures = settings.gpuShowTemperatures
    }
}
