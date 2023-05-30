//
//  Sensor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation


enum Sensor: String, CaseIterable {
    // CPU
    case Tp09 = "Tp09"
    case Tp0T = "Tp0T"
    case Tp01 = "Tp01"
    case Tp05 = "Tp05"
    case Tp0D = "Tp0D"
    case Tp0H = "Tp0H"
    case Tp0L = "Tp0L"
    case Tp0P = "Tp0P"
//    case Tp0X
//    case Tp0b
    // GPU
//    case Tg05
//    case Tg0D
//    case Tg0L
//    case Tg0T
    
    var key: String {
        return "\(self)"
    }
    
    var title: String {
        switch self {
        case .Tp09:
            return "CPU Efficiency core 1"
        case .Tp0T:
            return "CPU Efficiency core 2"
        case .Tp01:
            return "CPU Performance core 1"
        case .Tp05:
            return "CPU Performance core 2"
        case .Tp0D:
            return "CPU Performance core 3"
        case .Tp0H:
            return "CPU Performance core 4"
        case .Tp0L:
            return "CPU Performance core 5"
        case .Tp0P:
            return "CPU Performance core 6"
//        case .Tp0X:
//            return "CPU Performance core 7"
//        case .Tp0b:
//            return "CPU Performance core 8"
        }
    }
    
}
