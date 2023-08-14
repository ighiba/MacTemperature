//
//  VersionedTitle.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 14.08.2023.
//

import Cocoa

extension NSViewController {
    func setVersionedTitle(_ title: String) {
        self.title = makeVersionedTitle(title)
    }
}

extension NSWindow {
    func setVersionedTitle(_ title: String) {
        self.title = makeVersionedTitle(title)
    }
}

fileprivate func makeVersionedTitle(_ title: String) -> String {
    var newTitle = title
    if let version = Bundle.main.releaseVersionNumber {
        newTitle += " (\(version))"
    }
    return newTitle
}
