//
//  MenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa
import Combine

let statusBarMenuWidth: CGFloat = 220

class MenuView: NSMenu {
    
    // MARK: - Properties

    private var tempViews: [TemperatureSensorType : TemperaturesMenuView] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: MenuViewModelDelegate! {
        didSet {
            configureBindings()
            configureMenu()
        }
    }
    
    // MARK: - Methods
    
    private func configureBindings() {
        viewModel.temperatureMonitorDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tempMonitorData in
                for (sensor, data) in tempMonitorData {
                    self?.tempViews[sensor]?.updateRows(data: data)
                }
            }
            .store(in: &cancellables)
    }
    
    private func configureMenu() {
        let closeItem = NSMenuItem(title: "Close", action: #selector(closeButtonClicked), keyEquivalent: "q")
        let showWindowItem = NSMenuItem(title: "Show main window", action: #selector(showMainWindowClicked), keyEquivalent: "")
        let settingsItem = NSMenuItem(title: "Settings", action: #selector(settingsClicked), keyEquivalent: ",")
        closeItem.target = self
        showWindowItem.target = self
        settingsItem.target = self
        
        addTemperatureMenuItems()
        
        self.addItem(showWindowItem)
        self.addItem(NSMenuItem.separator())
        self.addItem(settingsItem)
        self.addItem(NSMenuItem.separator())
        self.addItem(closeItem)
    }
    
    private func addTemperatureMenuItems() {
        for sensor in TemperatureSensorType.allCases where viewModel.temperatureMonitorData[sensor] != nil {
            addTemperatureMenuItem(type: sensor)
        }
    }
    
    private func addTemperatureMenuItem(type: TemperatureSensorType) {
        let tempMenuItem = configureTemperatureMenuItem(type: type)
        tempViews[type] = configureTempView(type: type)
        tempMenuItem.view = tempViews[type]
        self.addItem(tempMenuItem)
        self.addItem(NSMenuItem.separator())
    }
    
    private func configureTemperatureMenuItem(type: TemperatureSensorType) -> NSMenuItem {
        let title = "\(type.stringValue) Temp"
        return NSMenuItem(title: title, action: nil, keyEquivalent: "")
    }
    
    private func configureTempView(type: TemperatureSensorType) -> TemperaturesMenuView {
        let title = "\(type.stringValue) Temperatures"
        return TemperaturesMenuView(title: title, type: type, initalData: viewModel.temperatureMonitorData[type] ?? [])
    }
}

// MARK: - Actions

extension MenuView {
    @objc func closeButtonClicked(_ sender: NSMenuItem) {
        viewModel.terminateApplication()
    }
    
    @objc func showMainWindowClicked(_ sender: NSMenuItem) {
        viewModel.showMainWindow()
    }
    
    @objc func settingsClicked(_ sender: NSMenuItem) {
        viewModel.showSettingsWindow()
    }
}