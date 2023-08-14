//
//  SettingsItemViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsItemViewController: NSViewController {
    
    var settingsWidth: CGFloat { 600 }
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsStack)
        settingsStack.orientation = .vertical
        setupLayout()
    }
    
    func setupLayout() {
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 30),
            settingsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    lazy var settingsView: NSView = {
        return NSView(frame: NSRect(x: 0, y: 0, width: settingsWidth, height: 200))
    }()
    
    var settingsStack: NSStackView = {
        let stack = NSStackView()
        stack.spacing = 15
        return stack
    }()
}
