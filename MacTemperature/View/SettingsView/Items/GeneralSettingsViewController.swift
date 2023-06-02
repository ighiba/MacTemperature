//
//  GeneralSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class GeneralSettingsViewController: SettingsItemViewController {

    lazy var mainWindowCheckbox = SettingsRowContainer(title: "Main window",
                                                    views: [NSButton(checkboxWithTitle: "Open at every launch", target: nil, action: nil)],
                                                    width: settingsWidth)
    lazy var launchAtLoginCheckbox = SettingsRowContainer(title: "Launch after start",
                                                       views: [NSButton(checkboxWithTitle: "The App will launch automatically after Mac start", target: self, action: nil)],
                                                       width: settingsWidth)
    lazy var updateFrequency = SettingsRowContainer(title: "Update frequency",
                                                 views: [getTextFieldForEdit("1"),
                                                         NSTextField(labelWithString: "seconds"),
                                                         NSButton(title: "Set", target: self, action: nil)],
                                                 width: settingsWidth)
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsStack.addArrangedSubview(mainWindowCheckbox)
        settingsStack.addArrangedSubview(launchAtLoginCheckbox)
        settingsStack.addArrangedSubview(updateFrequency)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.makeFirstResponder(nil)
    }
    
    func getTextFieldForEdit(_ string: String) -> NSTextField {
        let textField = NSTextField()
        
        textField.stringValue = string
        textField.isEditable = true
        textField.focusRingType = .none
        textField.alignment = .right
        textField.frame = NSRect(x: 0, y: 0, width: 30, height: 30)
        
        return textField
    }
    
//    @objc func setNewFrequency() {
//
//    }
//
//    @objc func launchAtLoginCheckboxChanged(_ sender: NSButton) {
//
//    }
//
//    @objc func setNewFrequency() {
//
//    }
    
}
