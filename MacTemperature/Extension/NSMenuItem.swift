//
//  NSMenuItem.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 05.11.2023.
//

import Cocoa

extension NSMenuItem {
    convenience init(title string: String, target: AnyObject?, action selector: Selector?, keyEquivalent charCode: String) {
        self.init(title: string, action: selector, keyEquivalent: charCode)
        self.target = target
    }
}
