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
        
        self.views.forEach { controlStack.addArrangedSubview($0) }
        controlStack.orientation = .horizontal
        controlStack.distribution = .equalSpacing
        
        addSubview(titleTextField)
        addSubview(controlStack)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        controlStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.trailingAnchor.constraint(equalTo: controlStack.leadingAnchor, constant: -spacing),
            titleTextField.topAnchor.constraint(equalTo: topAnchor),

            controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: defaultWidth * 0.4),
            controlStack.widthAnchor.constraint(equalToConstant: views.map({ $0.frame.width}).reduce(0, +)),
            controlStack.topAnchor.constraint(equalTo: topAnchor),
            controlStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
