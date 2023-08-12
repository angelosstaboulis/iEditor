//
//  Helper.swift
//  iEditor
//
//  Created by Angelos Staboulis on 12/8/23.
//

import Foundation
class Helper{
    static let shared = Helper()
    private init(){}
    func searchString(viewController:ViewController,search:String)->NSRange{
        let range = viewController.textView.string.range(of: search)
        let newRange = NSRange(range!, in: viewController.textView.string)
        return newRange
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
