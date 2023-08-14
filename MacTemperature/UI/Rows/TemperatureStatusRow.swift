//
//  TemperatureStatusRow.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

class TemperatureStatusRow: NSView {
    
    var key: String = ""

    var frameRect = NSRect(x: 0, y: 0, width: 400, height: 50)
    
    init(key: String, title: String, value: Float) {
        super.init(frame: frameRect)
        
        self.key = key
        titleTextField.stringValue = title
        valueTextField.stringValue = "\(value)"
        
        addSubview(titleTextField)
        addSubview(valueTextField)
        setupLayout()
    }
    
    convenience init(data: TemperatureData) {
        self.init(key: data.id, title: data.title, value: data.floatValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            valueTextField.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            valueTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueTextField.topAnchor.constraint(equalTo: topAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    var titleTextField: NSTextField = {
        let textField = NSTextField()
        
        textField.isBezeled = false
        textField.isEditable = false
        textField.stringValue = "Unknown"
        textField.drawsBackground = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    var valueTextField: NSTextField = {
        let textField = NSTextField()
        
        textField.isBezeled = false
        textField.isEditable = false
        textField.stringValue = "0.0"
        textField.drawsBackground = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
}
