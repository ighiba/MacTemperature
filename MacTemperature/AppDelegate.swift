//
//  AppDelegate.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 28.05.2023.
//

import Cocoa
import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    var window: NSWindow?
    var settingsWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        StorageLoader.loadAllSharedSettings()
        
        StatusBarModuleAssembly.configureModule()
        TemperatureMonitor.shared.temperatureManager = TemperatureManagerImpl()
        TemperatureMonitor.shared.sensorsManager = SensorsManagerImpl()
        TemperatureMonitor.shared.start()
        
        setAppToLaunchAtMacStart(state: GeneralSettingsData.shared.appShouldLaunchAfterStart)

        if GeneralSettingsData.shared.mainWindowOpenEveryLaunch {
            showMainWindow()
        }
    }
    
    func windowWillClose(_ notification: Notification) {
        guard let windowToClose = notification.object as? NSWindow else { return }
        if windowToClose == window {
            hideMainWindow()
        } else if windowToClose == settingsWindow {
            hideSettingsWindow()
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            showMainWindow()
        }
        return true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        StorageLoader.saveAllSharedSettings()
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
        guard window == nil else {
            window?.makeKeyAndOrderFront(self)
            return
        }
        let mainController = MainModuleAssembly.configureModule()
        window = configureMainWindow(mainController)
        window?.makeKeyAndOrderFront(self)
    }
    
    public func showSettingsWindow() {
        NSApplication.shared.activate(ignoringOtherApps: true)
        guard settingsWindow == nil else {
            settingsWindow?.makeKeyAndOrderFront(self)
            return
        }
        let settingsController = SettingsModuleAssembly.configureModule()
        settingsWindow = configureSettingsWindow(settingsController)
        settingsWindow?.makeKeyAndOrderFront(self)
    }
    
    public func hideMainWindow() {
        window = nil
        print("Main Window closed")
    }
    
    public func hideSettingsWindow() {
        settingsWindow = nil
        print("Settings Window closed")
    }
}
