//
//  TemperatureTableView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import SwiftUI

private let titleColumnWidth: CGFloat = 180
private let temperatureColumWidth: CGFloat = 40
private let barColumnWidth: CGFloat = 400
public var tableWidth: CGFloat {
    return titleColumnWidth + temperatureColumWidth + barColumnWidth + 70
}

struct TemperatureTableView: View {
    @ObservedObject private var temperatureDataContainer: TemperatureDataContainer = TemperatureDataContainer()
    
    var body: some View {
        Table(temperatureDataContainer.data) {
            TableColumn("Name") { data in
                Text(data.title)
            }
            .width(titleColumnWidth)
            TableColumn("   °C") { data in
                Text(data.stringValue)
                    .frame(width: temperatureColumWidth, alignment: .center)
            }
            .width(temperatureColumWidth)
            TableColumn("") { data in
                HorizontalBar(value: data.floatValue, maxWidth: barColumnWidth)
                    .frame(width: barColumnWidth, alignment: .center)
                
            }
            .width(barColumnWidth)
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
