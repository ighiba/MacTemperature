//
//  main.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 09.08.2023.
//

import Foundation
import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
