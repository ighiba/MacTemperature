//
//  Constants.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 07.10.2023.
//

import Foundation

struct Constants {
    static let windowSize = WindowSize()
    static let width = Width()
}

struct WindowSize {
    let main = NSSize(width: 690, height: 400)
    let settings = NSSize(width: 600, height: 150)
    
    fileprivate init() {}
}

struct Width {
    let statusBarMenu: CGFloat = 230
    
    fileprivate init() {}
}
