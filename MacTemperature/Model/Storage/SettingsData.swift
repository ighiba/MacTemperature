//
//  SettingsData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

protocol SettingsData: Codable {
    associatedtype ReturnType: SettingsData
    static var storageKey: String { get }
    static func getDefaultSettings() -> ReturnType
}
