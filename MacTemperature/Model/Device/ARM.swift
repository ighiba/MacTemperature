//
//  ARM.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 04.06.2023.
//

import Foundation

struct CPUCores {
    var e: Int
    var p: Int
    var cores: Int { e + p }
}

enum ARM {
    case unknown
    
    case M1
    case M1Pro8c
    case M1Pro10c
    case M1Max
    case M1Ultra
    
    case M2
    case M2Pro10c
    case M2Pro12c
    case M2Max
    case M2Ultra

    static func get(modelId: String, by processorCount: Int) -> ARM {
        let cpu = Mac.listAll.first { modelId == $0.modelID && processorCount == $0.cpu.getCoresCount().cores }?.cpu
        return cpu ?? .unknown
    }
    
    private func getCoresCount() -> CPUCores {
        switch self {
        case .unknown:
            return CPUCores(e: 0, p: 0)
            
        case .M1:
            return CPUCores(e: 4, p: 4)
        case .M1Pro8c:
            return CPUCores(e: 2, p: 6)
        case .M1Pro10c:
            return CPUCores(e: 2, p: 8)
        case .M1Max:
            return CPUCores(e: 2, p: 8)
        case .M1Ultra:
            return CPUCores(e: 4, p: 16)
            
        case .M2:
            return CPUCores(e: 4, p: 4)
        case .M2Pro10c:
            return CPUCores(e: 4, p: 6)
        case .M2Pro12c:
            return CPUCores(e: 4, p: 8)
        case .M2Max:
            return CPUCores(e: 4, p: 8)
        case .M2Ultra:
            return CPUCores(e: 8, p: 16)
        }
    }
}
