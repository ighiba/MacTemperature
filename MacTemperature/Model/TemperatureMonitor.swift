//
//  TemperatureMonitor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Foundation

class TemperatureMonitor {
    
    static var lastValues: [SMCVal_t] = []
    static let shared = TemperatureMonitor()
    
    private var timer: DispatchSourceTimer?
    private var queue = DispatchQueue(label: "ru.ighiba.backgroundQueue")
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    private var secondsBetweenUpdate = GeneralSettingsData.shared.updateFrequencyInSeconds
    
    private var values: [SMCVal_t]! {
        didSet {
            Self.lastValues = values
            NotificationCenter.default.post(name: NotificationNames.temperatureUpdateNotifaction, object: values)
        }
    }
    
    private init () {
        NotificationCenter.default.addObserver(forName: NotificationNames.temperatureUpdateNotifaction, object: nil, queue: nil) { [weak self] notification in
            guard let newUpdateFrequency = notification.object as? Int, let strongSelf = self else { return }
            guard strongSelf.secondsBetweenUpdate != newUpdateFrequency else { return }
            strongSelf.stop()
            strongSelf.secondsBetweenUpdate = newUpdateFrequency
            strongSelf.start()
        }
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
