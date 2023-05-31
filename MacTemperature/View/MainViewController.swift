import Cocoa

class MainViewController: NSViewController, MainViewInput {

    var output: MainViewOutput!
    
    var mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        let tempStatusData = output.getSampleData()
        mainView.setRows(data: tempStatusData)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateRows(data: [TemperatureStatusData]) {
        mainView.updateRows(data: data)
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
        statusRow.widthAnchor.constraint(equalTo: rowView.widthAnchor, multiplier: 0.9).isActive = true
        statusRow.centerXAnchor.constraint(equalTo: rowView.centerXAnchor).isActive = true
        statusRow.centerYAnchor.constraint(equalTo: rowView.centerYAnchor).isActive = true
        
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return nil
    }
}
 
