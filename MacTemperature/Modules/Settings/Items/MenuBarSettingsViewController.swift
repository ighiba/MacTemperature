//
//  MenuBarSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class MenuBarSettingsViewController: SettingsItemViewController {
    
    lazy var settings: MenuBarSettingsData = {
        return delegate.getMenuBarSettings()
    }()
    
    var delegate: MenuBarSettingsDelegate!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsStack.addArrangedSubview(cpuShowTemperatures)
        settingsStack.addArrangedSubview(gpuShowTemperatures)
    }
    
    lazy var cpuShowTemperatures = SettingsRowContainer(title: "CPU",
                                                    views: [getCpuShowTemperaturesCheckboxButton()],
                                                    width: settingsWidth)
    lazy var gpuShowTemperatures = SettingsRowContainer(title: "GPU",
                                                    views: [getGpuShowTemperaturesCheckboxButton()],
                                                    width: settingsWidth)
    
    private func getCpuShowTemperaturesCheckboxButton() -> NSButton {
        let button = NSButton(checkboxWithTitle: "Show temperatures",
                              target: self,
                              action: #selector(cpuShowTemperaturesCheckboxChanged))
        button.state = settings.cpuShowTemperatures ? .on : .off
        return button
    }
    
    private func getGpuShowTemperaturesCheckboxButton() -> NSButton {
        let button = NSButton(checkboxWithTitle: "Show temperatures",
                              target: self,
                              action: #selector(gpuShowTemperaturesCheckboxChanged))
        button.state = settings.gpuShowTemperatures ? .on : .off
        return button
    }
    
    @objc func cpuShowTemperaturesCheckboxChanged(_ sender: NSButton) {
        settings.cpuShowTemperatures = sender.state == .on ? true : false
        delegate.setMenuBarSettings(settings)
    }

    @objc func gpuShowTemperaturesCheckboxChanged(_ sender: NSButton) {
        settings.gpuShowTemperatures = sender.state == .on ? true : false
        delegate.setMenuBarSettings(settings)
    }
}
