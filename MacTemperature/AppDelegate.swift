//
//  AppDelegate.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 28.05.2023.
//

import Cocoa
import ServiceManagement

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var window: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainController = MainModuleAssembly.configureMoule()
        
        StatusBarModuleAssembly.configureModule()
        TemperatureMonitorModuleAssembly.configureModule()
        
        do {
            try SMAppService.mainApp.register() 
        } catch {
            print("SMAppService failed to register")
        }
        
        window = configureWindow(mainController)
        window?.makeKeyAndOrderFront(nil)
    }

    private func configureWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
        let windowSize = NSSize(width: tableWidth, height: 400)
        
        let newWindow = NSWindow(contentRect: NSRect(origin: CGPoint(), size: windowSize), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        newWindow.contentViewController = contentViewcontroller
        
        newWindow.contentMinSize = windowSize
        newWindow.contentMaxSize = windowSize

        newWindow.title = "MacTemperature"
        newWindow.delegate = self
        newWindow.isReleasedWhenClosed = false
        newWindow.center()
        
        return newWindow
    }
    
    func windowWillClose(_ notification: Notification) {
        window = nil
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            let mainController = MainModuleAssembly.configureMoule()

            window = configureWindow(mainController)
            window?.makeKeyAndOrderFront(nil)
        }
        return true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }



}

