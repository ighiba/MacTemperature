import Cocoa
import SwiftUI

class MainViewController: NSViewController, MainViewInput, ObservableObject {

    var output: MainViewOutput!
    
    private var tableViewSwiftUI = TemperatureTableView()

    override func loadView() {
        let hostingController = NSHostingController(rootView: tableViewSwiftUI)
        hostingController.view.frame = NSRect(x: 0, y: 0, width: tableWidth, height: 400)
        self.view = hostingController.view
    }
    
    deinit {
        print("MainViewController deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.loadAndUpdateInitalData()
    }
    
    func updateRows(data: [TemperatureData]) {
        tableViewSwiftUI.updateData(data)
    }
}
