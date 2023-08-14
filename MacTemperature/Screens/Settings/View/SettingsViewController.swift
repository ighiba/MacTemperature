//
//  SettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

protocol GeneralSettingsDelegate: SettingsDelegate {
    var generalSettings: GeneralSettingsData { get }
    func setGeneralSettings(_ settings: GeneralSettingsData)
}

protocol MenuBarSettingsDelegate: SettingsDelegate {
    var menuBarSettings: MenuBarSettingsData { get }
    func setMenuBarSettings(_ settings: MenuBarSettingsData)
}

protocol StatusBarSettingsDelegate: SettingsDelegate {
    var statusBarSettings: StatusBarSettingsData { get }
    func setStatusBarSettings(_ settings: StatusBarSettingsData)
}

class SettingsViewControler: NSTabViewController {

    var viewModel: SettingsViewModelDelegate!
    
    var settingsView = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 200))

    override func loadView() {
        super.loadView()
        view.frame = NSRect(x: 0, y: 0, width: 600, height: 150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabStyle = .toolbar
        
        addTabViewItem(label: "General", systemSymbolName: "gearshape", viewController: GeneralSettingsViewController())
        addTabViewItem(label: "Menu Bar", systemSymbolName: "menubar.rectangle", viewController: MenuBarSettingsViewController())
        addTabViewItem(label: "Status Bar", systemSymbolName: "thermometer.medium", viewController: StatusBarSettingsViewController())
    }
    
    private func addTabViewItem<T: SettingsItemView>(label: String, systemSymbolName: String, viewController: T) {
        let item = configureItem(label: label, systemSymbolName: systemSymbolName, viewController: viewController)
        addTabViewItem(item)
    }
    
    private func configureItem<T: SettingsItemView>(label: String, systemSymbolName: String, viewController: T) -> NSTabViewItem {
        let item = NSTabViewItem(viewController: viewController)
        viewController.delegate = self as? T.D
        item.configureItem(label: label, image: NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: nil)!)
        return item
    }
}

// MARK: - Delegates

extension SettingsViewControler: GeneralSettingsDelegate {
    var generalSettings: GeneralSettingsData { viewModel.generalSettings }
    
    func setGeneralSettings(_ settings: GeneralSettingsData) {
        viewModel.setGeneralSettings(settings)
    }
}

extension SettingsViewControler: MenuBarSettingsDelegate {
    var menuBarSettings: MenuBarSettingsData { viewModel.menuBarSettings }
    
    func setMenuBarSettings(_ settings: MenuBarSettingsData) {
        viewModel.setMenuBarSettings(settings)
    }
}

extension SettingsViewControler: StatusBarSettingsDelegate {
    var statusBarSettings: StatusBarSettingsData { viewModel.statusBarSettings }
    
    func setStatusBarSettings(_ settings: StatusBarSettingsData) {
        viewModel.setStatusBarSettings(settings)
    }
}

