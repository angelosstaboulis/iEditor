//
//  AppDelegate.swift
//  iEditor
//
//  Created by Angelos Staboulis on 11/8/23.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var saveFileAs = NSSavePanel()
    var viewController:ViewController!
    var searchText:SearchText!
    var newFileName:String!
    var newRange:NSRange!
    @IBAction func mnuCut(_ sender: Any) {
        Helper.shared.mnuCut(viewController: viewController)
    }
    @IBAction func mnuFind(_ sender: Any) {
        NSApplication.shared.orderedWindows.last?.contentViewController?.presentAsModalWindow(searchText)
        NotificationCenter.default.addObserver(self, selector: #selector(getValue), name: NSNotification.Name("Range"), object: nil)
    }
    
    @IBAction func mnuCopy(_ sender: Any) {
        Helper.shared.mnuCopy(viewController: viewController)
    }
    @IBAction func mnuPaste(_ sender: Any) {
        Helper.shared.mnuPaste(viewController: viewController)
    }
    
    @IBAction func mnuDelete(_ sender: Any) {
        Helper.shared.mnuDelete(viewController: viewController)
    }
    
    @IBAction func mnuSelectAll(_ sender: Any) {
        Helper.shared.mnuSelectAll(viewController: viewController)
    }
    @IBAction func mnuFileNew(_ sender: Any) {
        let newFile = NSSavePanel()
        viewController.textView.string = ""
        newFile.title = "Create New File"
        if newFile.runModal() == .OK {
            newFileName = newFile.directoryURL!.path + "/" + newFile.nameFieldStringValue
        }
        
        
    }
    @IBAction func mnuSaveAs(_ sender: Any) {
        let getText = viewController.textView.string
        saveFileAs.title = "Save File As"
        saveFileAs.nameFieldStringValue = self.newFileName
        saveFileAs.begin { [self] response in
            if response == .OK {
                FileManager.default.createFile(atPath: self.newFileName, contents:getText.data(using: .utf8), attributes: [:])
            }
        }
        saveFileAs.runModal()
    }
    @IBAction func mnuPrint(_ sender: Any) {
        let printPanel = NSPrintOperation(view: viewController.view)
        printPanel.run()
    }
    
    @IBAction func mnuOpen(_ sender: Any) {
        do{
            let openFile = NSOpenPanel()
            openFile.title = "Open File"
            openFile.canChooseFiles = true
            openFile.canChooseDirectories = true
           
            if openFile.runModal() == .OK {
                let contents = try String(contentsOf: URL(fileURLWithPath: openFile.url!.path))
                viewController.textView.string = contents
            }
           
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        viewController =  (NSApplication.shared.orderedWindows.first?.contentViewController as? ViewController)!
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        searchText =  storyboard.instantiateController(withIdentifier: "SearchText") as? SearchText
        searchText.title = "Search Text"
       
    }
    @objc func getValue(notification:NSNotification){
        newRange = (notification.object as! NSRange)
        viewController.textView.setSelectedRange(newRange)
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

