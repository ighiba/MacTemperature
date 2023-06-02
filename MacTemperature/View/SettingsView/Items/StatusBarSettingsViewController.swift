//
//  StatusBarSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class StatusBarSettingsViewController: SettingsItemViewController {
    
    lazy var showIcon = SettingsRowContainer(title: "Icon",
                                          views: [NSButton(checkboxWithTitle: "Show thermometer icon", target: nil, action: nil)],
                                          width: settingsWidth)
    lazy var avgTemperature = SettingsRowContainer(title: "Average temperature for",
                                                views: [getPopUpButton()],
                                                width: settingsWidth)
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsStack.addArrangedSubview(showIcon)
        settingsStack.addArrangedSubview(avgTemperature)
    }
    
    func getPopUpButton() -> NSPopUpButton {
        let popUpButton = NSPopUpButton(frame: NSRect(x: 0, y: 0, width: 60, height: 30))
        
        popUpButton.addItems(withTitles: ["CPU", "GPU"])
        popUpButton.selectItem(at: 0)
        
        return popUpButton
    }
    
}
