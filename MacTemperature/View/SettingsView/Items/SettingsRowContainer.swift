//
//  SettingsRowContainer.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class SettingsRowContainer: NSView {
    
    var defaultWidth: CGFloat
    var spacing: CGFloat = 10
    
    var titleTextField: NSTextField
    var controlStack: NSStackView = NSStackView(views: [])
    var views: [NSView]
    
    init(title: String, views: [NSView], width: CGFloat) {
        self.titleTextField = NSTextField(labelWithString: title + ":")
        self.views = views
        self.defaultWidth = width
        
        super.init(frame: NSRect(x: 0, y: 0, width: width, height: 50))
        
        self.views.forEach { self.controlStack.addArrangedSubview($0) }
        self.controlStack.orientation = .horizontal
        self.controlStack.distribution = .equalSpacing
        
        self.addSubview(self.titleTextField)
        self.addSubview(self.controlStack)

        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.controlStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleTextField.trailingAnchor.constraint(equalTo: self.controlStack.leadingAnchor, constant: -spacing),
            self.titleTextField.topAnchor.constraint(equalTo: self.topAnchor),

            self.controlStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: defaultWidth * 0.4),
            self.controlStack.widthAnchor.constraint(equalToConstant: self.views.map({ $0.frame.width}).reduce(0, +)),
            self.controlStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.controlStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
