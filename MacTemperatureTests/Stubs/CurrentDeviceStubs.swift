//
//  CurrentDeviceStubs.swift
//  MacTemperatureTests
//
//  Created by Ivan Ghiba on 13.08.2023.
//

import Foundation
@testable import MacTemperature

/// MacBook Air (M1, 2020)
class MacBookAir10_1_Device: CurrentDevice {
    override class var processorCount: Int { 8 }
    
    override class func getModelIdentifier() -> String? {
        return "MacBookAir10,1"
    }
}

/// MacBook Pro (M1 Pro 10C, 14-inch, 2021)
class MacBookPro18_3_Device: CurrentDevice {
    override class var processorCount: Int { 10 }
    
    override class func getModelIdentifier() -> String? {
        return "MacBookPro18,3"
    }
}

/// MacBook Pro (M1 Max, 14-inch, 2021)
class MacBookPro18_4_Device: CurrentDevice {
    override class var processorCount: Int { 10 }
    
    override class func getModelIdentifier() -> String? {
        return "MacBookPro18,4"
    }
}

/// Mac Studio (M1 Ultra, 2022)
class Mac13_2_Device: CurrentDevice {
    override class var processorCount: Int { 20 }
    
    override class func getModelIdentifier() -> String? {
        return "Mac13,2"
    }
}

/// Mac mini (M2, 2023)
class Mac14_3_Device: CurrentDevice {
    override class var processorCount: Int { 8 }
    
    override class func getModelIdentifier() -> String? {
        return "Mac14,3"
    }
}

/// MacBook Pro (M2 Pro 12C, 14-inch, 2023)
class Mac14_9_Device: CurrentDevice {
    override class var processorCount: Int { 12 }
    
    override class func getModelIdentifier() -> String? {
        return "Mac14,9"
    }
}
