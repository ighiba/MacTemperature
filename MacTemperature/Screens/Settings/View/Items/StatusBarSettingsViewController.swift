//
//  StatusBarSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

private let popUpButtonSize: NSSize = NSSize(width: 60, height: 30)

class StatusBarSettingsViewController: SettingsItemViewController, SettingsItemView {
        
    var settings: StatusBarSettingsData  { delegate.statusBarSettings }
    
    var delegate: StatusBarSettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        settingsRowsStack.addArrangedSubview(showIconContainer)
        settingsRowsStack.addArrangedSubview(averageTemeperatureSensorContainer)
    }
    
    // MARK: - Views
    
    lazy var showIconContainer = SettingRowContainer(
        title: "Icon",
        views: [configureShowIconCheckbox()],
        width: settingsWidth
    )
    
    lazy var averageTemeperatureSensorContainer = SettingRowContainer(
        title: "Average temperature for",
        views: [configureTemperatureSensorsPopUpButton()],
        width: settingsWidth
    )
    
    private func configureShowIconCheckbox() -> NSButton {
        let button = NSButton(
            checkboxWithTitle: "Show thermometer icon",
            target: self,
            action: #selector(showIconCheckboxStateDidChange)
        )
        button.state = settings.statusBarShowIcon ? .on : .off
        
        return button
    }
    
    private func configureTemperatureSensorsPopUpButton() -> NSPopUpButton {
        let popUpButton = NSPopUpButton(frame: NSRect(origin: .zero, size: popUpButtonSize))
        let titles = TemperatureSensorType.allCases.map { $0.stringValue }
        popUpButton.addItems(withTitles: titles)
        popUpButton.selectItem(at: settings.statusBarAverageTemperatureFor.rawValue)
        popUpButton.action = #selector(selectedAverageTemperatureSensorDidChange)
        popUpButton.target = self
        
        return popUpButton
    }
}

// MARK: - Actions

extension StatusBarSettingsViewController {
    @objc func showIconCheckboxStateDidChange(_ sender: NSButton) {
        settings.statusBarShowIcon = sender.state == .on ? true : false
        delegate.setStatusBarSettings(settings)
    }

    @objc func selectedAverageTemperatureSensorDidChange(_ sender: NSPopUpButton) {
        settings.statusBarAverageTemperatureFor = TemperatureSensorType(rawValue: sender.indexOfSelectedItem) ?? .cpu
        delegate.setStatusBarSettings(settings)
    }
}
