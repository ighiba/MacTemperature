//
//  NotificationNames.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 03.06.2023.
//

import Foundation

extension Notification.Name {
    static let temperatureMonitorUpdateNotification = Notification.Name("ru.ighiba.temperatureMonitorUpdateNotification")
    static let updateFrequencyChangeNotification = Notification.Name("ru.ighiba.updateFrequencyChangeNotification")
    static let isStatusBarIconEnabledChangeNotification = Notification.Name("ru.ighiba.isStatusBarIconEnabledChangeNotification")
    static let averageTemperatureSensorChangeNotification = Notification.Name("ru.ighiba.averageTemperatureSensorChangeNotification")
    static let menuUpdateNotification = Notification.Name("ru.ighiba.menuUpdateNotification")
}
