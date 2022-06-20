//
//  AppDelegate.swift
//  Recoord
//
//  Created by Benoit Pasquier on 25/1/21.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var window: NSWindow!
    var statusBarItem: NSStatusItem!
    let settings = UserSettings(userDefault: .standard)
    var defaultCollectionBehavior: NSWindow.CollectionBehavior!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(settings)

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.closable, .resizable],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = true
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating
        window.backgroundColor = .clear
        window.isMovable = true
        window.isMovableByWindowBackground = true
        defaultCollectionBehavior = window.collectionBehavior
        if !settings.isCurrentSpaceOnly {
            // Show the overlay over all spaces and over full screen apps
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        }
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        statusBarItem.menu = makeMenu()
                
        if let button = self.statusBarItem.button {
            button.title = "Recoord"
        }
    }
    
    func makeMenu() -> NSMenu {
        let menu = NSMenu(title: "Recoord")
        
        let rectangleItem = NSMenuItem(title: "Rectangle Shape", action: #selector(makeRectangleCamera), keyEquivalent: "")
        rectangleItem.state = settings.shape == .rectangle ? .on : .off 
        menu.addItem(rectangleItem)
        
        let circleItem = NSMenuItem(title: "Circle Shape", action: #selector(makeCircleCamera), keyEquivalent: "")
        circleItem.state = settings.shape == .circle ? .on : .off
        menu.addItem(circleItem)
        
        menu.addItem(.separator())
        
        let mirrorItem = NSMenuItem(title: "Mirror camera", action: #selector(mirrorCamera), keyEquivalent: "")
        mirrorItem.state = settings.isMirroring ? .on : .off
        menu.addItem(mirrorItem)

        let currentSpaceOnlyItem = NSMenuItem(title: "Current space only", action: #selector(currentSpaceOnly), keyEquivalent: "")
        currentSpaceOnlyItem.state = settings.isCurrentSpaceOnly ? .on : .off
        menu.addItem(currentSpaceOnlyItem)

        menu.addItem(.separator())
        
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "")
        
        return menu
    }
    
    @objc func makeRectangleCamera() {
        settings.shape = .rectangle
        statusBarItem.menu?.item(withTitle: "Rectangle Shape")?.state = .on
        statusBarItem.menu?.item(withTitle: "Circle Shape")?.state = .off
        
    }
    
    @objc func makeCircleCamera() {
        settings.shape = .circle
        
        statusBarItem.menu?.item(withTitle: "Rectangle Shape")?.state = .off
        statusBarItem.menu?.item(withTitle: "Circle Shape")?.state = .on    
    }
    
    @objc func mirrorCamera() {
        settings.isMirroring.toggle()
        
        let state: NSControl.StateValue = settings.isMirroring ? .on : .off
        statusBarItem.menu?.item(withTitle: "Mirror camera")?.state = state
    }
    
    @objc func currentSpaceOnly() {
        settings.isCurrentSpaceOnly.toggle()
        
        window.collectionBehavior = settings.isCurrentSpaceOnly ? defaultCollectionBehavior : [.canJoinAllSpaces, .fullScreenAuxiliary]
        let state: NSControl.StateValue = settings.isCurrentSpaceOnly ? .on : .off
        statusBarItem.menu?.item(withTitle: "Current space only")?.state = state
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

class UserSettings: ObservableObject {
    @Published var shape = Shape.circle {
        didSet {
            UserDefaults.standard.setValue(shape.rawValue, forKey: "camera.shape")
        }
    }
    
    @Published var isMirroring = false {
        didSet {
            UserDefaults.standard.setValue(isMirroring, forKey: "camera.isMirroring")
        }
    }
    
    @Published var isCurrentSpaceOnly = false {
        didSet {
            UserDefaults.standard.setValue(isCurrentSpaceOnly, forKey: "camera.isCurrentSpaceOnly")
        }
    }

    enum Shape: String {
        case circle
        case rectangle
    }
    
    init(userDefault: UserDefaults) {
        self.shape = Shape(rawValue: userDefault.string(forKey: "camera.shape") ?? "") ?? .circle
        self.isMirroring = userDefault.bool(forKey: "camera.isMirroring")
        self.isCurrentSpaceOnly = userDefault.bool(forKey: "camera.isCurrentSpaceOnly")
    }
}
