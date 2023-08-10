//
//  NSTabViewItem.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Cocoa

extension NSTabViewItem {
    func configureItem(label: String, image: NSImage) {
        self.label = label
        self.image = image
        self.viewController?.title = label
    }
}
