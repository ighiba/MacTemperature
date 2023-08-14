//
//  NSMutableAttributedString+Extensions.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa

extension NSMutableAttributedString {
    func addColorAttribute(_ color: NSColor, range: NSRange) {
        let colorAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: color]
        addAttributes(colorAttribute, range: range)
    }
    
    class func formatTemperatureValue(
        _ floatValue: Float,
        scale: UInt8 = 0,
        colorProvider: (() -> NSColor)? = nil
    ) -> NSMutableAttributedString {
        let stringValue = String(format: "%.\(scale)f", floatValue)
        let newTitle = "\(stringValue)°C"
        
        let defaultlColorProvider: () -> NSColor = { NSColor.labelColor }
        
        let getColor = colorProvider ?? defaultlColorProvider
        
        let attributedTitle = NSMutableAttributedString(string: newTitle)

        let rangeToPaintValue = NSRange(location: 0, length: newTitle.count - 1)
        let rangeToPaintC = NSRange(location: newTitle.count - 2, length: 2)
        attributedTitle.addColorAttribute(getColor(), range: rangeToPaintValue)
        attributedTitle.addColorAttribute(NSColor.labelColor, range: rangeToPaintC)
        
        return attributedTitle
    }
}
