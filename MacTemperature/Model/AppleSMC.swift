//
//  AppleSMC.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//
//  Based on https://github.com/exelban/stats/blob/master/SMC/smc.swift

import IOKit

class AppleSMC {
    
    var connection: io_connect_t = 0
    
    static var shared = AppleSMC()
    
    init() {
        let matchingDictionary = IOServiceMatching("AppleSMC")
        var result: kern_return_t
        var iterator: io_iterator_t = 0
        let device: io_object_t
        
        result = IOServiceGetMatchingServices(kIOMainPortDefault, matchingDictionary, &iterator)
        if result != kIOReturnSuccess {
            fatalError("Error")
        }
        
        device = IOIteratorNext(iterator)
        IOObjectRelease(iterator)
        if device == 0 {
            fatalError("Error")
        }
        
        result = IOServiceOpen(device, mach_task_self_, 0, &connection)
        IOObjectRelease(device)
        if result != kIOReturnSuccess {
            fatalError("Error")
        }
    }
}
