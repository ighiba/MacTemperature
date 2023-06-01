//
//  AppDelegate.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 28.05.2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainController = MainModuleAssembly.configureMoule()
        
        let windowSize = NSSize(width: tableWidth, height: 400)
        
        window = NSWindow(contentRect: NSRect(origin: CGPoint(), size: windowSize), styleMask: [.titled, .closable, .miniaturizable], backing: .buffered, defer: false)
        window.contentViewController = mainController
        
        window.contentMinSize = windowSize
        window.contentMaxSize = windowSize

        window.makeKeyAndOrderFront(nil)
        window.title = "MacTemperature"
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

