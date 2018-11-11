//
// Created by Duncan DeVore on 12/5/15.
// Copyright (c) 2015 ___ironfish___. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

@objc class GappleMessageViewController: NSObject {
    @objc class func onLoad() {
        Utils.instance.dispatchOnce(self, clazz: Clazz.MessageViewController)
    }
    
    @objc dynamic func swizKeyDown(_ event:NSEvent) {
        let utils: Utils = Utils.instance
        let key: String = utils.getChar(event)
        
        NSLog("\(Clazz.MessageViewController.rawValue): \(event)")
        
        switch key {
        case "n":
            self.swizKeyDown(utils.getEvent(self, withKey: Codes.ArrowRt.get()))
        case "p":
            self.swizKeyDown(utils.getEvent(self, withKey: Codes.ArrowLf.get()))
        default:
            self.swizKeyDown(event)
        }
    }
}
