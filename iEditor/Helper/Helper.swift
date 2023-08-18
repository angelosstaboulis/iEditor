//
//  Helper.swift
//  iEditor
//
//  Created by Angelos Staboulis on 12/8/23.
//

import Foundation
import AppKit
class Helper{
    static let shared = Helper()
    private init(){}
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
        saveFileAs.begin { response in
            if response == .OK {
                FileManager.default.createFile(atPath: newFileName, contents:getText.data(using: .utf8), attributes: [:])
            }
        }
        saveFileAs.runModal()
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
