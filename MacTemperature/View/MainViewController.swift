import Cocoa
import IOKit

class MainViewController: NSViewController, MainViewInput {

    var output: MainViewOutput!
    
    var mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        let values = SensorsManager().getValues(Sensor.allCases)
        let tempStatusData = values.map {
            TemperatureStatusData(smcValue: $0)
        }
        mainView.setRows(data: tempStatusData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.startMeasuringTemperature()
    }
    
    func updateRows(data: [TemperatureStatusData]) {
        mainView.updateRows(data: data)
    }
}
    
 
