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
    var settingsWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        do {
            try SMAppService.mainApp.register() 
        } catch {
            print("SMAppService failed to register")
        }
        
        StatusBarModuleAssembly.configureModule()
        TemperatureMonitorModuleAssembly.configureModule()
        
        let mainController = MainModuleAssembly.configureMoule()

        self.window = configureMainWindow(mainController)
        self.window?.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
    
    func windowWillClose(_ notification: Notification) {
        guard let windowToClose = notification.object as? NSWindow else { return }
        if windowToClose == window {
            self.hideMainWindow()
        } else if windowToClose == settingsWindow {
            self.hideSettingsWindow()
        }
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
    
    func configureMainWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
        let windowSize = NSSize(width: tableWidth, height: 400)
        
        let newWindow = NSWindow(contentRect: NSRect(origin: CGPoint(), size: windowSize), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        newWindow.contentViewController = contentViewcontroller
        
        newWindow.contentMinSize = windowSize
        newWindow.contentMaxSize = windowSize

        newWindow.title = "MacTemperature"
        newWindow.isReleasedWhenClosed = false
        newWindow.canHide = false
        newWindow.center()
        
        return newWindow
    }
    
    func configureSettingsWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
        let windowSize = NSSize(width: 600, height: 200)
        
        let newWindow = NSWindow(contentRect: NSRect(origin: CGPoint(), size: windowSize), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        newWindow.contentViewController = contentViewcontroller
        
        newWindow.contentMinSize = windowSize
        newWindow.contentMaxSize = windowSize

        newWindow.delegate = self
        newWindow.isReleasedWhenClosed = false
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
        self.window = self.configureMainWindow(mainController)
        self.window?.delegate = self
        self.window?.makeKeyAndOrderFront(self)
    }
    
    public func showSettingsWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard self.settingsWindow == nil else {
            self.settingsWindow?.makeKeyAndOrderFront(self)
            return
        }
        let vc = SettingsViewControler()
        self.settingsWindow = NSWindow(contentViewController: vc)
        self.settingsWindow?.delegate = self
        self.settingsWindow?.makeKeyAndOrderFront(self)
        let windowVC = NSWindowController(window: self.settingsWindow)
        windowVC.showWindow(self)
    }
    
    public func hideMainWindow() {
        self.window = nil
    }
    
    public func hideSettingsWindow() {
        self.settingsWindow = nil
    }
}
