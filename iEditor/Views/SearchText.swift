//
//  SearchText.swift
//  iEditor
//
//  Created by Angelos Staboulis on 12/8/23.
//

import Cocoa
import SwiftUI
class SearchText: NSViewController {
    var newRange:NSRange!
    var mainViewController:ViewController!
    @IBOutlet var txtSearch: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewController =  (NSApplication.shared.orderedWindows.first?.contentViewController as? ViewController)!
        // Do view setup here.
    }
    @IBAction func btnSearch(_ sender: Any) {
        newRange = Helper.shared.searchString(viewController: mainViewController, search: txtSearch.stringValue)
        NotificationCenter.default.post(name: NSNotification.Name("Range"), object: newRange )
        self.dismiss(self)
    }
}

