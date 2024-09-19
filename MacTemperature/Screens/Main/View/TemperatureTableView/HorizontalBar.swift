//
//  HorizontalBar.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 01.06.2023.
//

import SwiftUI

struct HorizontalBar: View {
    
    private let maxTemperature: Float = 130
    private let maxHeight: CGFloat = 20
    private var widthInCelsius: CGFloat { maxWidth / maxTemperature.cgFloat }
    
    private var barTintColor: Color { temperature.level.getBarColor() }
    private let barBackgroundColor: Color = Color(.lightGray)
    
    var temperature: Temperature
    var maxWidth: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(barBackgroundColor)
                .frame(width: maxWidth, height: maxHeight)
        }
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(barTintColor)
                .frame(width: temperature.value.cgFloat * widthInCelsius, height: maxHeight)
        }
        .cornerRadius(maxHeight / 4.5)
    }
}

#Preview {
    HorizontalBar(temperature: 40.0, maxWidth: 300)
}
