//
//  TemperatureTableView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import SwiftUI

struct TemperatureTableView: View {
    @ObservedObject private var temperatureDataContainer: TemperatureDataContainer = TemperatureDataContainer()
    
    var body: some View {
        
        Table(temperatureDataContainer.data) {
            TableColumn("Name", value: \.title)
            TableColumn("Temperature", value: \.stringValue)
            //TableColumn("", \.title)
        }
    }
    
    public func updateData(_ data: [TemperatureData]) {
        self.temperatureDataContainer.updateData(data)
    }
}

struct TemperatureTableView_Previews: PreviewProvider {

    static var previews: some View {
        TemperatureTableView()
    }
}
