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

        self.window = configureWindow(mainController)
        self.window?.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    func windowWillClose(_ notification: Notification) {
        self.hideMainWindow()
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            self.showMainWindow()
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

extension AppDelegate {
    
    func configureWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
        let windowSize = NSSize(width: tableWidth, height: 400)
        
        let newWindow = NSWindow(contentRect: NSRect(origin: CGPoint(), size: windowSize), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        newWindow.contentViewController = contentViewcontroller
        
        newWindow.contentMinSize = windowSize
        newWindow.contentMaxSize = windowSize

        newWindow.title = "MacTemperature"
        newWindow.delegate = self
        newWindow.isReleasedWhenClosed = false
        newWindow.canHide = false
        newWindow.center()
        
        return newWindow
    }
    
    public func showMainWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard self.window == nil else {
            self.window?.makeKeyAndOrderFront(self)
            return
        }
        let mainController = MainModuleAssembly.configureMoule()
        self.window = self.configureWindow(mainController)
        self.window?.makeKeyAndOrderFront(self)
    }
    
    public func hideMainWindow() {
        self.window = nil
    }
}
