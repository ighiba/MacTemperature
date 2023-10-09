//
//  MenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.06.2023.
//

import Cocoa
import Combine

class MenuView: NSMenu {
    
    // MARK: - Properties

    private var tempViews: [TemperatureSensorType : TemperaturesMenuView] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: MenuViewModelDelegate
    
    init(viewModel: MenuViewModelDelegate) {
        self.viewModel = viewModel
        super.init(title: "")
        self.configureBindings()
        self.configureMenu()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        addItem(showWindowItem)
        addItem(.separator())
        addItem(settingsItem)
        addItem(.separator())
        addItem(closeItem)
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
        addItem(tempMenuItem)
        addItem(.separator())
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
