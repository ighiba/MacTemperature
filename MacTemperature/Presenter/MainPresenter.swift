//
//  MainPresenter.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Foundation

protocol MainViewOutput: AnyObject {
    
}

protocol MainViewInput: AnyObject {
    
}

class MainPresenter: MainViewOutput {
    weak var input: MainViewInput!
}
