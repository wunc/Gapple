//
// Created by Duncan DeVore on 12/13/15.
// Copyright (c) 2015 ___ironfish___. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

@objc class GappleMessageListController: NSObject {
    @objc class func onLoad() {
        Utils.instance.dispatchOnce(self, clazz: Clazz.MessageListController)
    }
    
    @objc dynamic func swizKeyDown(_ event: NSEvent) {
        let utils: Utils = Utils.instance
        let key: String = utils.getChar(event)
        
        NSLog("\(Clazz.MessageListController.rawValue): \(event)")
        
        switch key {
        case "u":  // so we don't close the main window
            self.eventDate = nil
        //      shorts.action(self, selector: Selectors.Unread)
        default:
            self.swizKeyDown(event)
        }
    }
}
