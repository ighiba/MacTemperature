//
//  GeneralSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class GeneralSettingsViewController: SettingsItemViewController {
 
    lazy var settings: GeneralSettingsData = {
        return delegate.getGeneralSettings()
    }()
    
    var delegate: GeneralSettingsDelegate!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsStack.addArrangedSubview(mainWindowCheckbox)
        settingsStack.addArrangedSubview(launchAfterStartnCheckbox)
        settingsStack.addArrangedSubview(updateFrequency)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(nil)
    }
    
    lazy var mainWindowCheckbox = SettingsRowContainer(title: "Main window",
                                                    views: [getMainWindowCheckboxButton()],
                                                    width: settingsWidth)
    lazy var launchAfterStartnCheckbox = SettingsRowContainer(title: "Launch after start",
                                                          views: [getLaunchAfterStartCheckboxButton()],
                                                          width: settingsWidth)
    lazy var updateFrequency = SettingsRowContainer(title: "Update frequency",
                                                 views: [textFieldForEdit,
                                                         NSTextField(labelWithString: "seconds"),
                                                         NSButton(title: "Set", target: self, action: #selector(setNewFrequency))],
                                                 width: settingsWidth)
    
    
    private func getMainWindowCheckboxButton() -> NSButton {
        let button = NSButton(checkboxWithTitle: "Open at every launch",
                              target: self,
                              action: #selector(mainWindowCheckboxChanged))
        button.state = settings.mainWindowOpenEveryLaunch ? .on : .off
        return button
    }
    
    private func getLaunchAfterStartCheckboxButton() -> NSButton {
        let button = NSButton(checkboxWithTitle: "The App will launch automatically after Mac start",
                              target: self,
                              action: #selector(launchAfterStartnCheckboxChanged))
        button.state = settings.appShouldLaunchAfterStart ? .on : .off
        return button
    }
    
    lazy var textFieldForEdit: NSTextField = {
        let textField = NSTextField()
        
        textField.stringValue = "\(settings.updateFrequencyInSeconds)"
        textField.isEditable = true
        textField.focusRingType = .none
        textField.alignment = .right
        textField.frame = NSRect(x: 0, y: 0, width: 30, height: 30)
        
        return textField
    }()
    
    @objc func mainWindowCheckboxChanged(_ sender: NSButton) {
        settings.mainWindowOpenEveryLaunch = sender.state == .on ? true : false
        delegate.setGeneralSettings(settings)
    }

    @objc func launchAfterStartnCheckboxChanged(_ sender: NSButton) {
        settings.appShouldLaunchAfterStart = sender.state == .on ? true : false
        delegate.setGeneralSettings(settings)
    }

    @objc func setNewFrequency() {
        settings.updateFrequencyInSeconds = Int(textFieldForEdit.stringValue) ?? 1
        delegate.setGeneralSettings(settings)
    }
    
}
