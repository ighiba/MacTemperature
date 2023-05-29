//
//  TemperatureManager.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 29.05.2023.
//

import Foundation

class TemperatureManager {
    
    
    init() {
        
    }
    
    func updateTempValue(_ value: UnsafeMutablePointer<SMCVal_t>) {
        let result = AppleSMC.shared.read(value)
        if result != kIOReturnSuccess {
            fatalError("Error")
        }
    }
    
    func getAverageTempFor(_ values: [SMCVal_t]) -> Float {
        let temps = values.map { Float($0.bytes) ?? 0.0 }
        let sum = temps.reduce(0, +)
        
        return sum / Float(temps.count)
    }
    
    
//    func getTemperature(for sensor: Sensor) -> Float {
//        
//        let kernelIndex: UInt32 = 2
//        let readBytes: UInt32 = 5
//        let readKeyInfo: UInt8 = 9
//                
//        var input = SMCKeyData_t()
//        var output = SMCKeyData_t()
//        
//        input.key = FourCharCode(fromString: sensor.key)
//        input.data8 = readKeyInfo
//
//        var value = SMCVal_t(sensor.key)
//        var result: kern_return_t
//        
//        result = AppleSMC.shared.call(kernelIndex, input: &input, output: &output)
//        if result != kIOReturnSuccess {
//            fatalError("Error")
//        }
//        
//        value.dataSize = UInt32(output.keyInfo.dataSize)
//        value.dataType = output.keyInfo.dataType.toString()
//        input.keyInfo.dataSize = output.keyInfo.dataSize
//        input.data8 = UInt8(readBytes)
//        
//        result = AppleSMC.shared.call(kernelIndex, input: &input, output: &output)
//        if result != kIOReturnSuccess {
//            fatalError("Error")
//        }
//
//        memcpy(&value.bytes, &output.bytes, Int(value.dataSize))
// 
//        
//        if let temperature = Float(value.bytes) {
//            return temperature
//        }
//        
//        return 0.0
//    }
    
    
}
