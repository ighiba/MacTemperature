//
//  SettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

protocol GeneralSettingsDelegate {
    func getGeneralSettings() -> GeneralSettingsData
    func setGeneralSettings(_ settings: GeneralSettingsData)
}

protocol MenuBarSettingsDelegate {
    func getMenuBarSettings() -> MenuBarSettingsData
    func setMenuBarSettings(_ settings: MenuBarSettingsData)
}

protocol StatusBarSettingsDelegate {
    func getStatusBarSettings() -> StatusBarSettingsData
    func setStatusBarSettings(_ settings: StatusBarSettingsData)
}

class SettingsViewControler: NSTabViewController,
                           SettingsInput,
                           GeneralSettingsDelegate,
                           MenuBarSettingsDelegate,
                           StatusBarSettingsDelegate {

    var output: SettingsOutput!

    override func loadView() {
        super.loadView()
        self.view.frame = NSRect(x: 0, y: 0, width: 600, height: 150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabStyle = .toolbar
       
        let generalSettingsVC = GeneralSettingsViewController()
        generalSettingsVC.delegate = self
        let generalSettingsItem = NSTabViewItem(viewController: generalSettingsVC)
        let menuBarSettingsVC = MenuBarSettingsViewController()
        menuBarSettingsVC.delegate = self
        let menuSettingsItem = NSTabViewItem(viewController: menuBarSettingsVC)
        let statusBarSettingsVC = StatusBarSettingsViewController()
        statusBarSettingsVC.delegate = self
        let statusBarSettingsItem = NSTabViewItem(viewController: statusBarSettingsVC)
        
        generalSettingsItem.configureItem(label: "General",
                                         image: NSImage(systemSymbolName: "gearshape", accessibilityDescription: nil)!)
        menuSettingsItem.configureItem(label: "Menu Bar",
                                      image: NSImage(systemSymbolName: "menubar.rectangle", accessibilityDescription: nil)!)
        statusBarSettingsItem.configureItem(label: "Status Bar",
                                           image: NSImage(systemSymbolName: "thermometer.medium", accessibilityDescription: nil)!)

        self.addTabViewItem(generalSettingsItem)
        self.addTabViewItem(menuSettingsItem)
        self.addTabViewItem(statusBarSettingsItem)
    }
    
    var settingsView: NSView = {
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 400, height: 200))
        
        return view
    }()
    
    // MARK: - Methods
    
    func getGeneralSettings() -> GeneralSettingsData {
        return output.getGeneralSettings()
    }
    
    func setGeneralSettings(_ settings: GeneralSettingsData) {
        self.output.setGeneralSettings(settings)
    }
    
    func getMenuBarSettings() -> MenuBarSettingsData {
        return output.getMenuBarSettings()
    }
    
    func setMenuBarSettings(_ settings: MenuBarSettingsData) {
        self.output.setMenuBarSettings(settings)
    }
    
    func getStatusBarSettings() -> StatusBarSettingsData {
        return output.getStatusBarSettings()
    }
    
    func setStatusBarSettings(_ settings: StatusBarSettingsData) {
        self.output.setStatusBarSettings(settings)
    }
    
}

extension NSTabViewItem {
    func configureItem(label: String, image: NSImage) {
        self.label = label
        self.image = image
        self.viewController?.title = label
    }
}

