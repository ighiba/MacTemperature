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
        return TemperatureSensorType.allCases.lazy.compactMap({ self[$0] }).reduce([], +)
    }
}

class TemperatureMonitor {
    
    static var lastData: TemperatureMonitorData = [:]
    static let shared = TemperatureMonitor()
    
    private var timer: DispatchSourceTimer?
    private var queue = DispatchQueue(label: "ru.ighiba.backgroundQueue")

    private var secondsBetweenUpdate = GeneralSettingsData.shared.updateFrequencyInSeconds
    
    private var data: TemperatureMonitorData! {
        didSet {
            Self.lastData = data
            NotificationCenter.default.post(name: .temperatureMonitorUpdateNotification, object: data)
        }
    }
    
    var temperatureManager: TemperatureManager!
    var sensorsManager: SensorsManager!
    
    private init () {
        NotificationCenter.default.addObserver(forName: .updateFrequencyChangeNotification, object: nil, queue: nil) { [weak self] notification in
            guard let newUpdateFrequency = notification.object as? Int, newUpdateFrequency != self?.secondsBetweenUpdate else { return }
            self?.stop()
            self?.secondsBetweenUpdate = newUpdateFrequency
            self?.start()
        }
    }
    
    func start() {
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(secondsBetweenUpdate))
        
        timer?.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            var newData: TemperatureMonitorData = [:]
            for sensorType in TemperatureSensorType.allCases {
                let sensors = strongSelf.sensorsManager.getCurrentDeviceSensors([sensorType])
                var tempData: [TemperatureData] = []
                for sensor in sensors {
                    guard let floatValue = strongSelf.temperatureManager.getTemperature(for: sensor) else { continue }
                    tempData.append(TemperatureData(id: sensor.key, title: sensor.title, floatValue: floatValue))
                }
                newData.updateValue(tempData, forKey: sensorType)
            }
            strongSelf.data = newData
        }
        
        timer?.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
}
