import Cocoa
import SwiftUI

class MainViewController: NSViewController, MainViewInput, ObservableObject {

    var output: MainViewOutput!
    
    private var mainView = MainView()
    private var tableViewSwiftUI = TemperatureTableView()
    
    private var isSwiftUITable = true

    override func loadView() {
        if isSwiftUITable {
            // SwiftUI
            let hostingController = NSHostingController(rootView: tableViewSwiftUI)
            hostingController.view.frame = NSRect(x: 0, y: 0, width: tableWidth, height: 400)
            self.view = hostingController.view
        } else {
            // Cocoa
            self.view = mainView
            mainView.tableView.dataSource = self
            mainView.tableView.delegate = self
        }
    }
    
    deinit {
        print("MainViewController deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateRows(data: [TemperatureData]) {
        if isSwiftUITable {
            tableViewSwiftUI.updateData(data)
        } else {
            mainView.updateRows(data: data)
        }
    }
}

extension MainViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
}
    
extension MainViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.output.getSampleData().count
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let rowView = NSTableRowView(frame: NSRect(x: 0, y: 0, width: 100, height: 50))
        rowView.backgroundColor = .red
        let statusRow = mainView.rows[row]
        rowView.addSubview(statusRow)
        statusRow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusRow.widthAnchor.constraint(equalTo: rowView.widthAnchor, multiplier: 0.9),
            statusRow.centerXAnchor.constraint(equalTo: rowView.centerXAnchor),
            statusRow.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])

        return rowView
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return nil
    }
}
 
