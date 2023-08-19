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
    @IBOutlet weak var mnuEdit: NSMenu!
    
    var viewController:ViewController!
    var searchText:SearchText!
    var newFileName:String!
    var newRange:NSRange!
    func setupEditor(){
        viewController = Helper.shared.initialViewController()
        searchText = Helper.shared.initialSearchController()
        Helper.shared.initialEditor(mnuEdit: mnuEdit)
    }
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
        newFileName = Helper.shared.mnuNewFile()
        
    }
    @IBAction func mnuSaveAs(_ sender: Any) {
        Helper.shared.mnuSaveFileAs(mnuViewController: viewController, newFileName: newFileName)
    }
    @IBAction func mnuPrint(_ sender: Any) {
        Helper.shared.mnuPrintFile(mnuViewController: viewController)
    }
    
    @IBAction func mnuOpen(_ sender: Any) {
        Helper.shared.mnuOpenFile(mnuViewController:viewController)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupEditor()
       
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

