//
//  SettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsViewControler: NSTabViewController {

    override func loadView() {
        super.loadView()
        self.view.frame = NSRect(x: 0, y: 0, width: 600, height: 150)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabStyle = .toolbar
       
        let generalSettingsItem = NSTabViewItem(viewController: GeneralSettingsViewController())
        let menuSettingsItem = NSTabViewItem(viewController: MenuBarSettingsViewController())
        let statusBarSettingsItem = NSTabViewItem(viewController: StatusBarSettingsViewController())
        
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
    
}

extension NSTabViewItem {
    func configureItem(label: String, image: NSImage) {
        self.label = label
        self.image = image
        self.viewController?.title = label
    }
}

