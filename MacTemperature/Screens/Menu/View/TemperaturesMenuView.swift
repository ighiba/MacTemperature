//
//  TemperaturesMenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Cocoa

private let titleTopSpacing: CGFloat = 5
private let stackViewTopSpacing: CGFloat = 10
private let verticalSpacing: CGFloat = 16.5

private let defaultHeight: CGFloat = 300

class TemperaturesMenuView: NSView {
    
    private var titleLabel: NSTextField!
    private var stackView: NSStackView!
    private var rows: [TemperatureStatusBarRow]
    
    init(title: String, type: TemperatureSensorType, initalData: [TemperatureData]) {
        self.rows = initalData.map { TemperatureStatusBarRow(data: $0) }
        super.init(frame: NSRect(x: 0, y: 0, width: Constants.width.statusBarMenu, height: defaultHeight))
        self.setupViews(title: title)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        
        frame = NSRect(
            origin: frame.origin,
            size: NSSize(
                width: Constants.width.statusBarMenu,
                height: stackView.frame.height + stackView.frame.origin.x + 25
            )
        )
    }
    
    private func setupViews(title: String) {
        titleLabel = NSTextField(labelWithString: title)
        titleLabel.font = .boldSystemFont(ofSize: 13)

        stackView = NSStackView(views: rows)
        stackView.orientation = .vertical

        addSubview(titleLabel)
        addSubview(stackView)
    }

    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -2 * verticalSpacing),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: stackViewTopSpacing),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: titleTopSpacing),
        ])
        
        for row in rows {
            row.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                row.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            ])
        }
    }
    
    public func updateRows(data: [TemperatureData]) {
        for item in data {
            guard let row = rows.first(where: { $0.key == item.id }) else { continue }
            
            row.valueTextField.attributedStringValue = makeTemperatureAttributedString(item.temperature)
        }
    }
    
    private func makeTemperatureAttributedString(_ temperature: Temperature) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.makeTemperatureAttributedString(
            temperature.value,
            valueColor: temperature.level.getStatusBarColor()
        )
        attributedString.setAlignment(.right, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
