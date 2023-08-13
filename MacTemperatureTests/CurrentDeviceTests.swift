//
//  CurrentDeviceTests.swift
//  MacTemperatureTests
//
//  Created by Ivan Ghiba on 13.08.2023.
//

import XCTest
@testable import MacTemperature

final class CurrentDeviceTests: XCTestCase {

    func testM1GetCpu() throws {
        let cpu = MacBookAir10_1_Device.getCpu()
        
        XCTAssertEqual(cpu, .M1, "Wrong device cpu")
    }
    
    func testM1Pro10CoresGetCpu() throws {
        let cpu = MacBookPro18_3_Device.getCpu()
        
        XCTAssertEqual(cpu, .M1Pro10c, "Wrong device cpu")
    }
    
    func testM1MaxGetCpu() throws {
        let cpu = MacBookPro18_4_Device.getCpu()
        
        XCTAssertEqual(cpu, .M1Max, "Wrong device cpu")
    }
    
    func testM1UltraGetCpu() throws {
        let cpu = Mac13_2_Device.getCpu()
        
        XCTAssertEqual(cpu, .M1Ultra, "Wrong device cpu")
    }
    
    func testM2GetCpu() throws {
        let cpu = Mac14_3_Device.getCpu()
        
        XCTAssertEqual(cpu, .M2, "Wrong device cpu")
    }
    
    func testM2Pro12CoresGetCpu() throws {
        let cpu = Mac14_9_Device.getCpu()
        
        XCTAssertEqual(cpu, .M2Pro12c, "Wrong device cpu")
    }
}
