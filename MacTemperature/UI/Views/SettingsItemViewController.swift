//
//  SettingsItemViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

private let settingsWindowSize: NSSize = Constants.windowSize.settings
private let verticalSpacing: CGFloat = 15

class SettingsItemViewController: NSViewController {
    
    let settingsWidth: CGFloat = settingsWindowSize.width
    
    private var settingsView: NSView = NSView(frame: NSRect(origin: .zero, size: settingsWindowSize))
    private(set) var settingsStack = NSStackView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        settingsStack.orientation = .vertical
        settingsStack.spacing = verticalSpacing
        view.addSubview(settingsStack)
    }
    
    private func setupLayout() {
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsStack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: verticalSpacing * 2),
            settingsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
