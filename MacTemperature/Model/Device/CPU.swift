//
//  CPU.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 04.06.2023.
//

import Foundation

enum CPUGeneration {
    case unknown
    case M1
    case M2
}

protocol AppleSillicon {
    var efficiencyCores: UInt8 { get }
    var performanceCores: UInt8 { get }
    var generation: CPUGeneration { get }
    var totalCores: UInt8 { get }
}

struct CPU: AppleSillicon {
    
    var efficiencyCores: UInt8
    var performanceCores: UInt8
    var generation: CPUGeneration
    var totalCores: UInt8 {
        efficiencyCores + performanceCores
    }
    
    private init(e efficiencyCores: UInt8, p performanceCores: UInt8, gen generation: CPUGeneration) {
        self.efficiencyCores = efficiencyCores
        self.performanceCores = performanceCores
        self.generation = generation
    }
    
    static let unknown = CPU(e: 0, p: 0, gen: .unknown)
    
    static let M1       = CPU(e: 4, p: 4, gen: .M1)
    static let M1Pro8c  = CPU(e: 2, p: 6, gen: .M1)
    static let M1Pro10c = CPU(e: 2, p: 8, gen: .M1)
    static let M1Max    = CPU(e: 2, p: 8, gen: .M1)
    static let M1Ultra  = CPU(e: 4, p: 16, gen: .M1)
    
    static let M2       = CPU(e: 4, p: 4, gen: .M2)
    static let M2Pro10c = CPU(e: 4, p: 6, gen: .M2)
    static let M2Pro12c = CPU(e: 4, p: 8, gen: .M2)
    static let M2Max    = CPU(e: 4, p: 8, gen: .M2)
}
