//
//  SettingsStorage.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Foundation

class SettingsStorage {
    private let storage = UserDefaults.standard
    
    func loadData<T: Storable>() -> T {
        guard let data = storage.data(forKey: T.storageKey) else {
            print("\(T.ReturnType.self) no saved settings")
            return T.getDefaultData() as! T
        }
        
        if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
            return decodedData
        } else {
            print("\(T.ReturnType.self) settings cannot be decoded")
            return T.getDefaultData() as! T
        }
    }

    func saveData<T: Storable>(_ settings: T) {
        if let data = try? JSONEncoder().encode(settings) {
            storage.set(data, forKey: T.storageKey)
        } else {
            storage.removeObject(forKey: T.storageKey)
        }
        storage.synchronize()
    }

}
