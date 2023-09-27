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
private let temperaturesMenuSectionHeight: CGFloat = 300

class TemperaturesMenuView: NSView {
    
    private var titleLabel: NSTextField!
    private var stackView: NSStackView!
    private var rows: [TemperatureStatusBarRow]
    
    init(title: String, type: TemperatureSensorType, initalData: [TemperatureData]) {
        self.rows = initalData.map { TemperatureStatusBarRow(data: $0) }
        super.init(frame: NSRect(x: 0, y: 0, width: statusBarMenuWidth, height: temperaturesMenuSectionHeight))
        
        setupViews(title: title)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() {
        super.layout()
        frame = NSRect(
            origin: frame.origin,
            size: NSSize(
                width: statusBarMenuWidth,
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
            let row = rows.first { $0.key == item.id }
            guard let row else { continue }
            let newAttributedString = getDefaultTemperatureAttributedString(item.floatValue)
            newAttributedString.setAlignment(.right, range: NSRange(location: 0, length: newAttributedString.length))
            row.valueTextField.attributedStringValue = newAttributedString
        }
    }
    
    private func getDefaultTemperatureAttributedString(_ floatValue: Float) -> NSMutableAttributedString {
        let level = TemperatureLevel.getLevel(floatValue)
        return NSMutableAttributedString.formatTemperatureValue(floatValue, colorProvider: level.getMenuItemColor)
    }
}
