//
//  TemperatureStatusRow.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

private let frameRect = NSRect(x: 0, y: 0, width: 400, height: 50)

class TemperatureStatusRow: NSView {

    private(set) var titleTextField: NSTextField = NSTextField(labelWithString: "Unknown")
    private(set) var valueTextField: NSTextField = NSTextField(labelWithString: "0.0")
    
    private(set) var key: String
    
    init(key: String, title: String, value: Float) {
        self.key = key
        super.init(frame: frameRect)
        
        titleTextField.stringValue = title
        valueTextField.stringValue = "\(value)"
        
        setupViews()
        setupLayout()
    }
    
    convenience init(data: TemperatureData) {
        self.init(key: data.id, title: data.title, value: data.floatValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleTextField)
        addSubview(valueTextField)
    }
    
    func setupLayout() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        
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
}
