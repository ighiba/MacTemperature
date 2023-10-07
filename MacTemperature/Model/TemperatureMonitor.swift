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
    
    static let shared = TemperatureMonitor()
    static var lastData: TemperatureMonitorData = [:]
    
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
            self?.updateData()
        }
        
        timer?.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    private func updateData() {
        var newData: TemperatureMonitorData = [:]
        for sensorType in TemperatureSensorType.allCases {
            let sensors = sensorsManager.getCurrentDeviceSensors(sensorTypes: [sensorType])
            let temperatureData = obtainTemeperatureData(forSensors: sensors)
            newData.updateValue(temperatureData, forKey: sensorType)
        }
        data = newData
    }
    
    private func obtainTemeperatureData(forSensors sensors: [Sensor]) -> [TemperatureData] {
        return sensors.compactMap { sensor in
            guard let temperatureValue = temperatureManager.obtainTemperature(for: sensor) else { return nil }
            return TemperatureData(id: sensor.key, title: sensor.title, floatValue: temperatureValue)
        }
    }
}
