//
//  NSApplication+AppDelegate.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.10.2023.
//

import Cocoa

extension NSApplication {
    static var appDelegate: AppDelegate? { NSApplication.shared.delegate as? AppDelegate }
}
