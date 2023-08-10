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
        self.titleTextField.stringValue = title
        self.valueTextField.stringValue = "\(value)"
        
        self.addSubview(titleTextField)
        self.addSubview(valueTextField)
        setupLayout()
    }
    
    convenience init(data: TemperatureData) {
        self.init(key: data.id, title: data.title, value: data.floatValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        let constraints = [
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            valueTextField.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            valueTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            valueTextField.topAnchor.constraint(equalTo: self.topAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
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

class TemperatureStatusBarRow: TemperatureStatusRow {
    
    override init(key: String, title: String, value: Float) {
        super.init(key: key, title: title, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLayout() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            valueTextField.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            valueTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            valueTextField.topAnchor.constraint(equalTo: self.topAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
