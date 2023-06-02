//
//  MenuBarSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class MenuBarSettingsViewController: SettingsItemViewController {
    
    lazy var cpuShowTemperatures = SettingsRowContainer(title: "CPU",
                                                    views: [NSButton(checkboxWithTitle: "Show temperatures", target: nil, action: nil)],
                                                    width: settingsWidth)
    lazy var gpuShowTemperatures = SettingsRowContainer(title: "GPU",
                                                    views: [NSButton(checkboxWithTitle: "Show temperatures", target: nil, action: nil)],
                                                    width: settingsWidth)
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsStack.addArrangedSubview(cpuShowTemperatures)
        settingsStack.addArrangedSubview(gpuShowTemperatures)
    }
    
}
