//
//  TemperaturesMenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Cocoa

class TemperaturesMenuView: NSView {
    private var delegate: StatusBarDelegate!
    
    private var titleLabel: NSTextField!
    private var stackView: NSStackView!
    private var rows: [TemperatureStatusBarRow] = []
    
    init(title: String, type: TemperatureSensorType,  _ delegate: StatusBarDelegate) {
        super.init(frame: NSRect(x: 0, y: 0, width: statusBarMenuWidth, height: 300))
        
        self.delegate = delegate
        
        self.titleLabel = NSTextField(labelWithString: title)
        self.titleLabel.font = .boldSystemFont(ofSize: 13)
        self.loadDummyData(for: type)

        self.stackView = NSStackView(views: rows)
        self.stackView.orientation = .vertical

        self.addSubview(titleLabel)
        self.addSubview(stackView)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        self.frame = NSRect(origin: self.frame.origin, size: NSSize(width: statusBarMenuWidth,
                                                                height: stackView.frame.height * 1.21))
    }
    
    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        ])
        
        for row in rows {
            row.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                row.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            ])
        }
    }
    
    private func loadDummyData(for type: TemperatureSensorType) {
        let sensorsManager = SensorsManagerImpl()
        let sensors = sensorsManager.getSensorsForCurrentDevice(where: [type])
        let tempStatusData = sensors.map {
            TemperatureData(id: $0.key, title: $0.title, floatValue: 0.0)
        }
        rows = tempStatusData.map {
            TemperatureStatusBarRow(data: $0)
        }
    }
    
    public func updateRows(data: [TemperatureData]) {
        for item in data {
            let row = rows.first(where: { $0.key == item.id } )
            guard let row else { continue }
            let newAttributedString = delegate.getDefaultTemperatureAttributedString(item.floatValue)
            newAttributedString.setAlignment(.right, range: NSRange(location: 0, length: newAttributedString.length))
            row.valueTextField.attributedStringValue = newAttributedString
        }
    }
}
