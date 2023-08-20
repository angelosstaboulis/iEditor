//
//  Helper.swift
//  iEditor
//
//  Created by Angelos Staboulis on 12/8/23.
//

import Foundation
import AppKit
import SwiftUI
class Helper{
    static let shared = Helper()
    private init(){}
    func initialViewController()->ViewController{
        let viewController =  (NSApplication.shared.orderedWindows.first?.contentViewController as? ViewController)!
        return viewController
    }
    func initialSearchController()->SearchText{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let searchText =  storyboard.instantiateController(withIdentifier: "SearchText") as? SearchText
        searchText!.title = "Search Text"
        return searchText!
    }
    func initialEditor(mnuEdit:NSMenu){
        mnuEdit.items[8].isHidden = true
        mnuEdit.items[9].isHidden = true
  
    }
    func searchString(viewController:ViewController,search:String)->NSRange{
        let range = viewController.textView.string.range(of: search)
        let newRange = NSRange(range!, in: viewController.textView.string)
        return newRange
    }
    func mnuNewFile()->String{
        let newFile = NSSavePanel()
        var newFileName:String!
        newFile.title = "Create New File"
        if newFile.runModal() == .OK {
            newFileName = newFile.directoryURL!.path + "/" + newFile.nameFieldStringValue
        }
        return newFileName
    }
    func mnuOpenFile(mnuViewController:ViewController){
        do{
            let openFile = NSOpenPanel()
            openFile.title = "Open File"
            openFile.canChooseFiles = true
            openFile.canChooseDirectories = true
            if openFile.runModal() == .OK {
                let contents = try String(contentsOf: URL(fileURLWithPath: openFile.url!.path))
                mnuViewController.textView.string = contents
            }
           
        }catch{
            debugPrint("something went wrong!!!")
        }
    }
    func mnuSaveFileAs(mnuViewController:ViewController,newFileName:String){
        let saveFileAs = NSSavePanel()
        let getText = mnuViewController.textView.string
        saveFileAs.title = "Save File As"
        saveFileAs.nameFieldStringValue = newFileName
        if saveFileAs.runModal() == .OK{
            FileManager.default.createFile(atPath: newFileName, contents:getText.data(using: .utf8), attributes: [:])
        }
    }
    func mnuPrintFile(mnuViewController:ViewController){
        let printPanel = NSPrintOperation(view: mnuViewController.view)
        printPanel.run()
    }
    func mnuOpenFile(viewController:ViewController){
        
    }
    func mnuCut(viewController:ViewController){
        viewController.textView.cut(nil)
    }
    func mnuCopy(viewController:ViewController){
        viewController.textView.copy(nil)
    }
    func mnuPaste(viewController:ViewController){
        viewController.textView.paste(nil)
    }
    func mnuSelectAll(viewController:ViewController){
        viewController.textView.selectAll(nil)
    }
    func mnuDelete(viewController:ViewController){
        viewController.textView.delete(nil)
    }
}
