//
//  SettingsStorage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Foundation


//enum TemperatureSensorsTypes: Int, Codable {
//    case cpu = 0
//    case gpu = 1
//}
//
//class Settings: Codable {
//    
//    static let shared = Settings()
//    
//    var mainWindowOpenEveryLaunch = true
//    var appShouldLaunchAfterStart = true
//    var updateFrequenceInSeconds = 1
//    var cpuShowTemperatures = true
//    var gpuShowTemperatures = true
//    var statusBarShowIcon = true
//    var statusBarAverageTemperatureFor = TemperatureSensorsTypes.cpu
//    
//    init(mainWindowOpenEveryLaunch: Bool = true, appShouldLaunchAfterStart: Bool = true, updateFrequenceInSeconds: Int = 1, cpuShowTemperatures: Bool = true, gpuShowTemperatures: Bool = true, statusBarShowIcon: Bool = true, statusBarAverageTemperatureFor: TemperatureSensorsTypes = TemperatureSensorsTypes.cpu) {
//        self.mainWindowOpenEveryLaunch = mainWindowOpenEveryLaunch
//        self.appShouldLaunchAfterStart = appShouldLaunchAfterStart
//        self.updateFrequenceInSeconds = updateFrequenceInSeconds
//        self.cpuShowTemperatures = cpuShowTemperatures
//        self.gpuShowTemperatures = gpuShowTemperatures
//        self.statusBarShowIcon = statusBarShowIcon
//        self.statusBarAverageTemperatureFor = statusBarAverageTemperatureFor
//    }
//    
//    
//    class func getDefaultSettings() -> Settings {
//        Settings(mainWindowOpenEveryLaunch: true,
//                 appShouldLaunchAfterStart: true,
//                 updateFrequenceInSeconds: 1,
//                 cpuShowTemperatures: true,
//                 gpuShowTemperatures: true,
//                 statusBarShowIcon: true,
//                 statusBarAverageTemperatureFor: TemperatureSensorsTypes.cpu
//        )
//    }
//    
//}




class SettingsStorage {
    private let storage = UserDefaults.standard
    
    func loadData<T: SettingsData>() -> T {
        guard let data = storage.data(forKey: T.storageKey) else {
            print("\(T.ReturnType.self) no saved settings")
            return T.getDefaultSettings() as! T
        }
        
        if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
            return decodedData
        } else {
            print("\(T.ReturnType.self) settings cannot be decoded")
            return T.getDefaultSettings() as! T
        }
    }

    func saveData<T: SettingsData>(_ settings: T) {
        if let data = try? JSONEncoder().encode(settings) {
            storage.set(data, forKey: T.storageKey)
        } else {
            storage.removeObject(forKey: T.storageKey)
        }
        storage.synchronize()
    }
}
