//
//  NSMutableAttributedString+Extensions.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

extension NSMutableAttributedString {
    func addColorAttribute(_ color: NSColor, range: NSRange) {
        addAttributes([.foregroundColor: color], range: range)
    }
    
    class func formatTemperatureValue(
        _ floatValue: Float,
        scale: UInt8 = 0,
        valueColor: NSColor = .labelColor
    ) -> NSMutableAttributedString {
        let stringValue = String(format: "%.\(scale)f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        let attributedTitle = NSMutableAttributedString(string: newTitle)

        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: 2)
        attributedTitle.addColorAttribute(valueColor, range: rangeToPaintValue)
        attributedTitle.addColorAttribute(.labelColor, range: rangeToPaintC)
        
        return attributedTitle
    }
}
