//
//  Device.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 04.06.2023.
//

import Foundation

protocol MacDevice {
    var modelID: String { get }
    var cpu: CPU { get }
}

struct Mac: MacDevice {
    var modelID: String
    var cpu: CPU
    
    private init(modelID: String, cpu: CPU) {
        self.modelID = modelID
        self.cpu = cpu
    }
    
    static let listAll = [
        Mac(modelID: "iMac21,1", cpu: .M1),
        Mac(modelID: "iMac21,2", cpu: .M1),
        Mac(modelID: "Macmini9,1", cpu: .M1),
        Mac(modelID: "MacBookAir10,1", cpu: .M1),
        Mac(modelID: "MacBookPro17,1", cpu: .M1),
        Mac(modelID: "MacBookPro18,3", cpu: .M1Pro8c),
        Mac(modelID: "MacBookPro18,3", cpu: .M1Pro10c),
        Mac(modelID: "MacBookPro18,4", cpu: .M1Max),
        Mac(modelID: "MacBookPro18,1", cpu: .M1Pro10c),
        Mac(modelID: "MacBookPro18,2", cpu: .M1Max),
        Mac(modelID: "Mac13,1", cpu: .M1Max),
        Mac(modelID: "Mac13,2", cpu: .M1Ultra),
        
        Mac(modelID: "Mac14,12", cpu: .M2Pro10c),
        Mac(modelID: "Mac14,12", cpu: .M2Pro12c),
        Mac(modelID: "Mac14,3", cpu: .M2),
        Mac(modelID: "Mac14,2", cpu: .M2),
        Mac(modelID: "Mac14,7", cpu: .M2),
        Mac(modelID: "Mac14,9", cpu: .M2Pro10c),
        Mac(modelID: "Mac14,9", cpu: .M2Pro12c),
        Mac(modelID: "Mac14,5", cpu: .M2Max),
        Mac(modelID: "Mac14,10", cpu: .M2Pro12c),
        Mac(modelID: "Mac14,6", cpu: .M2Max),
    ]
}

struct UserDevice: MacDevice {
    var modelID: String
    var cpu: CPU = .unknown
    
    init(modelID: String, processorCount: Int) {
        self.modelID = modelID
        self.cpu = getCPU(by: UInt8(processorCount))
    }
    
    private func getCPU(by processorCount: UInt8) -> CPU {
        return Mac.listAll.first(where: { $0.modelID == self.modelID && $0.cpu.totalCores == processorCount })?.cpu ?? .unknown
    }
}

class CurrentDevice {
    class func getModelIdentifier() -> String? {
        var modelIdentifier: String?
        var size = 0
        
        sysctlbyname("hw.model", nil, &size, nil, 0)
        let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: size)
        sysctlbyname("hw.model", buffer, &size, nil, 0)
        modelIdentifier = String(cString: buffer)
        buffer.deallocate()
        
        return modelIdentifier
    }
}

