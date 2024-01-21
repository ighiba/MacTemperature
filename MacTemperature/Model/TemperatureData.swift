//
//  TemperatureData.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

struct TemperatureData: Identifiable {
    
    let id: String
    var title: String
    var floatValue: Float
    var stringValue: String { getStringValue() }
    
    init(id: String, title: String, floatValue: Float) {
        self.id = id
        self.title = title
        self.floatValue = floatValue
    }
    
    func getStringValue(scale: UInt8 = 1) -> String {
        return String(format: "%.\(scale)f", floatValue)
    }
}

extension [TemperatureData] {
    func getAverageTemperature() -> Float {
        guard !self.isEmpty else { return 0 }
        let temperatureValues = self.map({ $0.floatValue })
        let temperatureSum = temperatureValues.reduce(0, +)
        
        return temperatureSum / Float(temperatureValues.count)
    }
}
