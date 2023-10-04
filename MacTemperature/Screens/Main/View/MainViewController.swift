//
//  MainViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa
import SwiftUI

class MainViewController: NSViewController {

    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let temperatureTableView = TemperatureTableView(dataSource: viewModel)
        let hostingController = NSHostingController(rootView: temperatureTableView)
        hostingController.view.frame = NSRect(x: 0, y: 0, width: tableWidth, height: 400)
        view = hostingController.view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
