//
//  TemperatureMonitor.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 31.05.2023.
//

import Foundation

typealias TemperatureMonitorData = [TemperatureSensorType : [TemperatureData]]

extension TemperatureMonitorData {
    func transformIntoTemperatureData() -> [TemperatureData] {
        var tempData: [TemperatureData] = []
        for type in TemperatureSensorType.allCases {
            guard let data = self[type] else { continue }
            tempData.append(contentsOf: data)
        }
        return tempData
    }
}

class TemperatureMonitor {
    
    static var lastData: TemperatureMonitorData = [:]
    static let shared = TemperatureMonitor()
    
    private var timer: DispatchSourceTimer?
    private var queue = DispatchQueue(label: "ru.ighiba.backgroundQueue")
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    private var secondsBetweenUpdate = GeneralSettingsData.shared.updateFrequencyInSeconds
    
    private var data: TemperatureMonitorData! {
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
        self.timer = DispatchSource.makeTimerSource(queue: queue)
        self.timer?.schedule(deadline: .now(), repeating: .seconds(secondsBetweenUpdate))
        
        self.timer?.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            var newData: TemperatureMonitorData = [:]
            for type in TemperatureSensorType.allCases {
                let sensors = strongSelf.sensorsManager.getSensorsForCurrentDevice(where: [type])
                var tempData: [TemperatureData] = []
                for sensor in sensors {
                    guard let floatValue = strongSelf.temperatureManager.getTemperature(for: sensor) else { continue }
                    tempData.append(TemperatureData(id: sensor.key, title: sensor.title, floatValue: floatValue))
                }
                newData.updateValue(tempData, forKey: type)

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
