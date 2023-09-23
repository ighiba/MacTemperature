//
//  Storable.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

protocol Storable: Codable {
    static var storageKey: String { get }
    static func getDefault() -> Self
    func set(_ data: Self)
}
