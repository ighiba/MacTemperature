//
//  Bundle.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 14.08.2023.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? { infoDictionary?["CFBundleShortVersionString"] as? String }
    var buildVersionNumber: String? { infoDictionary?["CFBundleVersion"] as? String }
}
