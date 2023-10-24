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

private let settingsWindowSize: NSSize = Constants.windowSize.settings

class SettingsViewControler: NSTabViewController {

    private let settingsView = NSView()

    private let viewModel: SettingsViewModelDelegate
    
    init(viewModel: SettingsViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.frame = NSRect(origin: .zero, size: settingsWindowSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupItems()
    }
    
    private func setupStyle() {
        tabStyle = .toolbar
    }
    
    private func setupItems() {
        addTabViewItem(label: "General", image: .settingsIconGeneral, viewController: GeneralSettingsViewController())
        addTabViewItem(label: "Menu Bar", image: .settingsIconMenuBar, viewController: MenuBarSettingsViewController())
        addTabViewItem(label: "Status Bar", image: .settingsIconStatusBar, viewController: StatusBarSettingsViewController())
    }
    
    private func addTabViewItem<T: SettingsItemView>(label: String, image: NSImage, viewController: T) {
        let item = configureItem(label: label, image: image, viewController: viewController)
        addTabViewItem(item)
    }
    
    private func configureItem<T: SettingsItemView>(label: String, image: NSImage, viewController: T) -> NSTabViewItem {
        let item = NSTabViewItem(viewController: viewController)
        viewController.delegate = self as? T.D
        item.configureItem(label: label, image: image)
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
