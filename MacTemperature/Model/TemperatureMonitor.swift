//
//  TemperatureMonitor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Foundation

class TemperatureMonitor {
    
    static var lastData: [TemperatureData] = []
    static let shared = TemperatureMonitor()
    
    private var timer: DispatchSourceTimer?
    private var queue = DispatchQueue(label: "ru.ighiba.backgroundQueue")
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    private var secondsBetweenUpdate = GeneralSettingsData.shared.updateFrequencyInSeconds
    
    private var data: [TemperatureData]! {
        didSet {
            Self.lastData = data
            NotificationCenter.default.post(name: NotificationNames.temperatureUpdateNotifaction, object: data)
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
        let cpuSensors = sensorsManager.getSensorsForCurrentDevice(where: [.cpu])
        let gpuSensors = sensorsManager.getSensorsForCurrentDevice(where: [.gpu])
        let sensors = cpuSensors + gpuSensors
        
        self.timer = DispatchSource.makeTimerSource(queue: queue)
        self.timer?.schedule(deadline: .now(), repeating: .seconds(secondsBetweenUpdate))
        
        self.timer?.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            var newData: [TemperatureData] = []
            
            for sensor in sensors {
                guard let floatValue = strongSelf.temperatureManager.getTemperature(for: sensor) else { continue }
                newData.append(TemperatureData(id: sensor.key, title: sensor.title, floatValue: floatValue))
            }

            strongSelf.data = newData
        }
        
        timer?.resume()
    }
    
    func stop() {
        self.timer?.cancel()
        self.timer = nil
    }
    
}
