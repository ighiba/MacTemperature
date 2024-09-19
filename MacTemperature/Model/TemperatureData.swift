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
    var temperature: Temperature
    
    init(id: String, title: String, floatValue: Float) {
        self.id = id
        self.title = title
        self.temperature = Temperature(value: floatValue)
    }
}

extension [TemperatureData] {
    func getAverageTemperature() -> Temperature {
        guard !self.isEmpty else { return 0.0 }
        
        let temperatureValues = self.map { $0.temperature.value }
        let temperatureSum = temperatureValues.reduce(0, +)
        let averageTemperatureValue = temperatureSum / Float(temperatureValues.count)
        
        return Temperature(value: averageTemperatureValue)
    }
}
