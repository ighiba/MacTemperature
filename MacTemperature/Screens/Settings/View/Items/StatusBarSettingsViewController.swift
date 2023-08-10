//
//  StatusBarSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class StatusBarSettingsViewController: SettingsItemViewController, SettingsItemView {
        
    var settings: StatusBarSettingsData  { delegate.statusBarSettings }
    
    var delegate: StatusBarSettingsDelegate!

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsStack.addArrangedSubview(showIcon)
        settingsStack.addArrangedSubview(avgTemperature)
    }
    
    // MARK: - Views
    
    lazy var showIcon = SettingsRowContainer(
        title: "Icon",
        views: [getShowIconCheckboxButton()],
        width: settingsWidth
    )
    
    lazy var avgTemperature = SettingsRowContainer(
        title: "Average temperature for",
        views: [getPopUpButton()],
        width: settingsWidth
    )
    
    private func getShowIconCheckboxButton() -> NSButton {
        let button = NSButton(
            checkboxWithTitle: "Show thermometer icon",
            target: self,
            action: #selector(showIconCheckboxChanged)
        )
        button.state = settings.statusBarShowIcon ? .on : .off
        return button
    }
    
    func getPopUpButton() -> NSPopUpButton {
        let popUpButton = NSPopUpButton(frame: NSRect(x: 0, y: 0, width: 60, height: 30))
        
        popUpButton.addItems(withTitles: TemperatureSensorType.allCases.map({ $0.stringValue }))
        popUpButton.selectItem(at: settings.statusBarAverageTemperatureFor.rawValue)
        popUpButton.action = #selector(popUpButtonDidChanged)
        popUpButton.target = self
        
        return popUpButton
    }
}

// MARK: - Actions

extension StatusBarSettingsViewController {
    @objc func showIconCheckboxChanged(_ sender: NSButton) {
        settings.statusBarShowIcon = sender.state == .on ? true : false
        delegate.setStatusBarSettings(settings)
    }

    @objc func popUpButtonDidChanged(_ sender: NSPopUpButton) {
        settings.statusBarAverageTemperatureFor = TemperatureSensorType(rawValue: sender.indexOfSelectedItem) ?? .cpu
        delegate.setStatusBarSettings(settings)
    }
}
