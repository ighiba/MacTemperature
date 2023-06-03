//
//  TemperatureSensorTypes.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

enum TemperatureSensorType: Int, Codable, CaseIterable {
    case cpu = 0
    case gpu = 1
    
    func getString() -> String {
        switch self {
        case .cpu:
            return "CPU"
        case .gpu:
            return "GPU"
        }
    }
}
