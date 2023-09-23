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
            print("\(T.self) no saved settings, return default settings")
            return T.getDefault()
        }
        
        if let decodedData = try? JSONDecoder().decode(T.self, from: data) {
            return decodedData
        } else {
            print("\(T.self) stored settings cannot be decoded, return default settings")
            return T.getDefault()
        }
    }

    func saveData<T: Storable>(_ data: T) {
        if let encodedData = try? JSONEncoder().encode(data) {
            storage.set(encodedData, forKey: T.storageKey)
        } else {
            storage.removeObject(forKey: T.storageKey)
        }
        storage.synchronize()
    }
}
