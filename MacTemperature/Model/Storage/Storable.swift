//
//  Storable.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

protocol Storable: Codable {
    associatedtype ReturnType: Storable
    static var storageKey: String { get }
    static func getDefaultData() -> ReturnType
    func setData(_ settings: ReturnType)
}
