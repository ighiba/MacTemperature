//
//  MenuBarSettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

final class MenuBarSettingsData: Storable {
    
    static var storageKey: String { "menuBarSettings" }

    static let shared = MenuBarSettingsData()
    
    var cpuShowTemperatures: Bool
    var gpuShowTemperatures: Bool
    
    init(cpuShowTemperatures: Bool, gpuShowTemperatures: Bool) {
        self.cpuShowTemperatures = cpuShowTemperatures
        self.gpuShowTemperatures = gpuShowTemperatures
    }
    
    convenience init() {
        self.init(cpuShowTemperatures: true, gpuShowTemperatures: false)
    }
    
    static func getDefault() -> MenuBarSettingsData {
        return MenuBarSettingsData()
    }
    
    func set(_ data: MenuBarSettingsData) {
        cpuShowTemperatures = data.cpuShowTemperatures
        gpuShowTemperatures = data.gpuShowTemperatures
    }
}
