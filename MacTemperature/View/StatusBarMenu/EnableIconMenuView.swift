//
//  EnableIconMenuView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Cocoa

class EnableIconMenuItem: NSView {
    
    var delegate: StatusBarDelegate!
    
    init(_ delegate: StatusBarDelegate) {
        self.delegate = delegate
        super.init(frame: NSRect(x: 0, y: 0, width: 200, height: 30))
        
        let textLabel = NSTextField(labelWithString: "Enable icon")
        
        let enableIconSwitch = NSSwitch()
        enableIconSwitch.state = .on
        enableIconSwitch.target = delegate
        enableIconSwitch.action = #selector(delegate.enableIconSwitched)

        let containerView = NSView()
        
        containerView.addSubview(textLabel)
        containerView.addSubview(enableIconSwitch)
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        enableIconSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7),
            textLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            enableIconSwitch.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor),
            enableIconSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            enableIconSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
