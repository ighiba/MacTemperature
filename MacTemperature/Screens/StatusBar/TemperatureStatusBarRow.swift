//
//  TemperatureStatusBarRow.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Cocoa

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
