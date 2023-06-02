//
//  SettingsPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Foundation

protocol SettingsInput: AnyObject {
    
}

protocol SettingsOutput: AnyObject {
    
}

class SettingsPresenter: SettingsOutput {
    
    weak var input: SettingsInput!
    
    
    init() {
        
    }
}
