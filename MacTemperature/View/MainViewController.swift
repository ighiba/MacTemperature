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
        
        let stackView = NSStackView(frame: NSRect(x: 50, y: 0, width: view.frame.width, height: view.frame.height))
        self.view.addSubview(stackView)
        
        var values = SensorsManager().getValues(Sensor.allCases)
    
        DispatchQueue.global().async {
            while true {
                sleep(1)
                for _ in 0...16 {
                    print(" ")
                }
                
                for i in 0..<values.count {
                    TemperatureManager().updateTempValue(&values[i])
                }
                
                DispatchQueue.main.async {
                    let tempStatusData = values.map {
                        TemperatureStatusData(smcValue: $0)
                    }
                    self.mainView.updateRows(data: tempStatusData)
                    print("======================================")
                    tempStatusData.forEach { status in
                        print("\(status.title) = \(status.floatValue)")
                    }
                    print("======================================")
                }
            }
        }
    }
}
    
 
