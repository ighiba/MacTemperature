//
//  MainViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa
import SwiftUI

class MainViewController: NSViewController {

    var viewModel: MainViewModel!

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
