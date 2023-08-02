//
//  MainView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa

class MainView: NSView {
    
    var viewController: MainViewController!
    
    var rows: [TemperatureStatusRow]!
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 400, height: 400))
        self.loadDummyData()
        self.addSubview(tableView)
        
        setupLayout()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: NSTableView = {
        let table = NSTableView()
        
        table.style = .plain
        table.usesAlternatingRowBackgroundColors = true
        table.backgroundColor = NSColor.windowBackgroundColor
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    private func loadDummyData() {
        let sensorsManager = SensorsManagerImpl()
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [.cpu, .gpu])
        let tempStatusData = sensors.map {
            TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0)
        }
        rows = tempStatusData.map {
            TemperatureStatusRow(data: $0)
        }
    }
    
    func updateRows(data: [TemperatureData]) {
        // Update row's temperatureText (Causes crash in UITests)
        for item in data {
            let row = rows.first(where: { $0.key == item.id } )
            guard let row else { continue }
            row.valueTextField.stringValue = item.getStringValue(scale: 1)
        }
        
        // Update full table
//        rows = data.map {
//            TemperatureStatusRow(data: $0)
//        }
//        tableView.reloadData()
    }
}
