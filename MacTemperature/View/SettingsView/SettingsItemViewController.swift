//
//  SettingsItemViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsItemViewController: NSViewController {
    
    var settingsWidth: CGFloat {
        return 600
    }
    
    override func loadView() {
        self.view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(settingsStack)
        self.settingsStack.orientation = .vertical
        self.setupLayout()
    }
    
    func setupLayout() {
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 30),
            settingsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            settingsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    lazy var settingsView: NSView = {
        return NSView(frame: NSRect(x: 0, y: 0, width: self.settingsWidth, height: 200))
    }()
    
    var settingsStack: NSStackView = {
        let stack = NSStackView()
        stack.spacing = 15
        return stack
    }()
}
