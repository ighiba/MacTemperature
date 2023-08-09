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
    
    deinit {
        print("MainViewController deinited")
    }

    override func loadView() {
        let tableViewSwiftUI = TemperatureTableView(dataSource: viewModel)
        let hostingController = NSHostingController(rootView: tableViewSwiftUI)
        hostingController.view.frame = NSRect(x: 0, y: 0, width: tableWidth, height: 400)
        self.view = hostingController.view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
