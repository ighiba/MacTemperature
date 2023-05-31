//
//  TemperatureMonitor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Foundation

class TemperatureMonitor {
    
    static let temperatureUpdateNotifaction = Notification.Name("ru.ighiba.TemperatureUpdateNotifaction")
    static let shared = TemperatureMonitor()
    
    private var timer: DispatchSourceTimer?
    private var queue = DispatchQueue(label: "ru.ighiba.backgroundQueue")
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    private var secondsBetweenUpdate = 1
    
    private var values: [SMCVal_t]! {
        didSet {
            NotificationCenter.default.post(name: Self.temperatureUpdateNotifaction, object: values)
        }
    }
    
    private init () {
        
    }
    
    func start() {
        self.values = sensorsManager.getValues(Sensor.allCases)
        
        self.timer = DispatchSource.makeTimerSource(queue: queue)
        self.timer?.schedule(deadline: .now(), repeating: .seconds(secondsBetweenUpdate))
        
        self.timer?.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            
            var valuesCopy = strongSelf.values
            for i in 0..<valuesCopy!.count {
                strongSelf.temperatureManager.updateTemperatureValue(&valuesCopy![i])
            }
            
            strongSelf.values = valuesCopy
        }
        timer?.resume()
    }
    
    func stop() {
        self.timer?.cancel()
        self.timer = nil
    }
    
}
