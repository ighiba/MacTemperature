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
    
    var value: Float
    var maxWidth: CGFloat
    
    private var barColor: Color { getColorByCurrentValue(value) }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.lightGray))
                .frame(width: maxWidth, height: maxHeight)
        }
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(barColor)
                .frame(width: value.cgFloat * widthInCelsius, height: maxHeight)
        }
        .cornerRadius(maxHeight / 4.5)
    }
    
    private func getColorByCurrentValue(_ value: Float) -> Color {
        return TemperatureLevel.getLevel(value).getBarColor()
    }
}

struct HorizontalBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBar(value: 40.0, maxWidth: 300)
    }
}
