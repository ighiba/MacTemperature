//
//  HorizontalBar.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 01.06.2023.
//

import SwiftUI

extension Float {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

fileprivate let maxTemperature: Float = 130
fileprivate let maxWidth: CGFloat = 300
fileprivate let maxHeight: CGFloat = 20
fileprivate var pixelsInCelsius: CGFloat {
    return maxWidth / maxTemperature.cgFloat
}

struct HorizontalBar: View {
    
    public var value: Float
    private var barColor: Color {
        return getColorByCurrentValue(value)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.lightGray))
                .frame(width: maxWidth, height: maxHeight)
        }
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(barColor)
                .frame(width: value.cgFloat * pixelsInCelsius, height: maxHeight)
        }
        .cornerRadius(maxHeight / 4.5)
    }
    
    private func getColorByCurrentValue(_ value: Float) -> Color {
        return TemperatureLevel.getLevel(value).getBarColor()
    }
}

struct HorizontalBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBar(value: 40.0)
    }
}
