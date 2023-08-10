//
//  SettingsItemView.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Foundation

protocol SettingsItemView: SettingsItemViewController {
    associatedtype D = SettingsDelegate
    var delegate: D! { get set }
}
