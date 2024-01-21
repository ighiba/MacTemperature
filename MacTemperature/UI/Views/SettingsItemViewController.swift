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
    private(set) var settingsRowsStack: NSStackView = NSStackView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        settingsRowsStack.orientation = .vertical
        settingsRowsStack.spacing = verticalSpacing
        view.addSubview(settingsRowsStack)
    }
    
    private func setupLayout() {
        settingsRowsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsRowsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsRowsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: verticalSpacing * 2),
            settingsRowsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsRowsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
