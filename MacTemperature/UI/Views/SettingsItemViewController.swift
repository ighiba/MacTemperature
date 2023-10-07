//
//  SettingsItemViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

private let settingsWindowSize = Constants.windowSize.settings

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
        settingsStack.spacing = 15
        view.addSubview(settingsStack)
    }
    
    private func setupLayout() {
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 30),
            settingsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
