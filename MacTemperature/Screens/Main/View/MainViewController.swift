//
//  MainViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 30.05.2023.
//

import Cocoa
import SwiftUI

private let mainWindowSize: NSSize = Constants.windowSize.main

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
        view = configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() -> NSView {
        let temperatureTableView = TemperatureTableView(dataSource: viewModel)
        let hostingController = NSHostingController(rootView: temperatureTableView)
        hostingController.view.frame = NSRect(origin: .zero, size: mainWindowSize)
        
        return hostingController.view
    }
}
