//
//  TemperatureTextField.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Cocoa

class TemperatureTextField: NSTextField {
    
    init() {
        super.init(frame: NSRect(x: 0 , y: 0, width: 200, height: 50))
        self.font = self.font?.withSize(40)
        self.isEditable = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTemperature(_ temp: Float) {
        self.stringValue = "\(temp)"
        if temp > 55.0 {
            self.textColor = NSColor.orange
        } else {
            self.textColor = NSColor.black
        }
    }
    
}
