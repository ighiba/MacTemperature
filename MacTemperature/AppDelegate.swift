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
        StorageLoader.loadAllSharedSettings()
        
        StatusBarModuleAssembly.configureModule()
        TemperatureMonitorModuleAssembly.configureModule()
        
        self.setAppToLaunchAtMacStart(state: GeneralSettingsData.shared.appShouldLaunchAfterStart)

        if GeneralSettingsData.shared.mainWindowOpenEveryLaunch {
            self.showMainWindow()
        }
        
        self.showSettingsWindow()
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
    
    public func setAppToLaunchAtMacStart(state: Bool) {
        do {
            if state {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
            
        } catch {
            print("SMAppService failed \(error.localizedDescription)")
        }
    }
    
    func configureMainWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
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
    
    func configureSettingsWindow(_ contentViewcontroller: NSViewController) -> NSWindow {
        let settingsWindow = NSWindow(contentViewController: contentViewcontroller)
        
        settingsWindow.delegate = self
        settingsWindow.styleMask = [.titled, .closable]
        settingsWindow.center()
        
        return settingsWindow
    }
    
    public func showMainWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard self.window == nil else {
            self.window?.makeKeyAndOrderFront(self)
            return
        }
        let mainController = MainModuleAssembly.configureMoule()
        self.window = self.configureMainWindow(mainController)
        self.window?.makeKeyAndOrderFront(self)
    }
    
    public func showSettingsWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard self.settingsWindow == nil else {
            self.settingsWindow?.makeKeyAndOrderFront(self)
            return
        }
        let settingsController = SettingsModuleAssembly.configureModule()
        self.settingsWindow = self.configureSettingsWindow(settingsController)
        self.settingsWindow?.makeKeyAndOrderFront(self)
    }
    
    public func hideMainWindow() {
        self.window = nil
        print("Main Window closed")
    }
    
    public func hideSettingsWindow() {
        self.settingsWindow = nil
        print("Settings Window closed")
    }
}
