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
    
    private var barTintColor: Color { getColorByCurrentValue(value) }
    private let barBackgroundColor: Color = Color(.lightGray)
    
    var value: Float
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
                .frame(width: value.cgFloat * widthInCelsius, height: maxHeight)
        }
        .cornerRadius(maxHeight / 4.5)
    }
    
    private func getColorByCurrentValue(_ value: Float) -> Color {
        return TemperatureLevel.getLevel(value).getBarColor()
    }
}

#Preview {
    HorizontalBar(value: 40.0, maxWidth: 300)
}
