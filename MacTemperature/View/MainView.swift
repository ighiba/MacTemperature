//
//  MainView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

class MainView: NSView {
    
    var rows: [TemperatureStatusRow]!
    
    init() {
        super.init(frame: NSRect())
        
        //setupLayout()
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        rows.forEach { statusRow in
            statusRow.translatesAutoresizingMaskIntoConstraints = true
            statusRow.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        }
    }
    
    func setRows(data: [TemperatureStatusData]) {
        self.rows = data.map {
            TemperatureStatusRow(data: $0)
        }
        
        let stackView = NSStackView(views: rows )
        stackView.orientation = .vertical
        
        self.addSubview(stackView)

        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.rows.forEach { row in
            row.translatesAutoresizingMaskIntoConstraints = false
            row.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
            row.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        }
        //setupLayout()
    }
    
    func updateRows(data: [TemperatureStatusData]) {
        for item in data {
            let row = rows.first(where: { $0.key == item.key } )
            guard let row else { continue }
            row.valueTextField.setTemperature(item.floatValue)
        }
    }
    
}
