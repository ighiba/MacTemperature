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
    }
    
    convenience init(data: TemperatureStatusData) {
        self.init(key: data.key, title: data.title, value: data.floatValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()
        setupLayout()
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
        
        textField.stringValue = "CPU 1"
        
        textField.isEditable = false
        textField.font = textField.font?.withSize(20)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    var valueTextField: TemperatureTextField = {
        let textField = TemperatureTextField()
        
        textField.setTemperature(45.3)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
}
