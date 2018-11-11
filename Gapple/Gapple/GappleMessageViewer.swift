//
// Created by Duncan DeVore on 11/28/15.
// Copyright (c) 2015 ___ironfish___. All rights reserved.
//

import ScriptingBridge
import AppKit
import Cocoa
import Foundation

extension NSObject {
    private struct AssociatedKeys {
        static var EventDate = "nsh_EventDate"
    }
    var eventDate: NSDate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.EventDate) as? NSDate
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.EventDate,
                    newValue as NSDate?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}

@objc class GappleMessageViewer: NSObject {
    @objc open class func onLoad() {
        Utils.instance.dispatchOnce(self, clazz: Clazz.MessageViewer)
    }
    
    @objc dynamic func swizKeyDown(_ event:NSEvent) {
        let mail: MailboxService = MailboxService.instance
        let shorts: ShortcutService = ShortcutService.instance
        let utils: Utils = Utils.instance
        let key: String = utils.getChar(event)
        let hasAlternate: Bool = event.modifierFlags.contains(.option)
        let hasCommand: Bool = event.modifierFlags.contains(.command)
        let hasControl: Bool = event.modifierFlags.contains(.control)
        let isInterval: Bool = shorts.intervalValid(date: self.eventDate)
        
        NSLog("\(Clazz.MessageViewer.rawValue): \(event)")
        
        switch key {
        case "#":
            shorts.action(self, selector: Zelector.deleteMessages)
        case "!" where hasControl:
            shorts.action(self, selector: Zelector.markAsNotJunkMail)
        case "!":
            shorts.action(self, selector: Zelector.markAsJunkMail)
        case "/" where hasControl:
            self.eventDate = nil
        case "/":
            self.swizKeyDown(utils.getEvent(self, withKey: Codes.FKey.get(), andFlags: Masks.Cmd.get()))
            //      let utils = Utils.instance
            //      self.performSelector(Selector("ensureSearchFieldVisibilityInToolbar"), withObject: nil)
            //      let searchField = utils.getUnretainedObject(self, selector: "searchField")
        //      searchField.performSelector(Selector("setFocus:"), withObject: nil)
        case "a" where isInterval == true:
            mail.selectSpecialMailbox(self, zelector: Zelector.Archive)
        case "a":
            shorts.action(self, selector: Zelector.replyAllMessage)
        case "c" where isInterval == true:
            self.eventDate = nil
            let app = SBApplication(bundleIdentifier: "com.apple.addressbook")!
            app.activate()
        case "c":
            shorts.action(self, selector: Zelector.showComposeWindow)
        case "d" where isInterval == true:
            mail.selectSpecialMailbox(self, zelector: Zelector.draftsMailbox)
        case "e",
             "y":
            shorts.action(self, selector: Zelector.archiveMessages)
        case "f" where hasAlternate && hasCommand == true:
            self.swizKeyDown(event)
        case "f":
            shorts.action(self, selector: Zelector.forwardMessage)
        case "g":
            self.eventDate = NSDate()
            self.swizKeyDown(event)
        case "i" where isInterval == true:
            mail.selectSpecialMailbox(self, zelector: Zelector.inbox)
        case "I":
            shorts.action(self, selector: Zelector.markAsRead)
        case "l" where isInterval == true:
            mail.toMailbox(self, toAction: ToAction.Go)
        case "l":
            mail.toMailbox(self, toAction: ToAction.Copy)
        case "o":
            shorts.action(self, selector: Zelector.openMessages)
        case "n":
            self.swizKeyDown(utils.getEvent(self, withKey: Codes.ArrowRt.get()))
        case "p":
            self.swizKeyDown(utils.getEvent(self, withKey: Codes.ArrowLf.get()))
        case "r":
            shorts.action(self, selector: Zelector.replyMessage)
        case "s" where isInterval == true:
            mail.selectSpecialMailbox(self, zelector: Zelector.Flagged)
        case "s":
            shorts.action(self, selector: Zelector.toggleFlag)
        case "t" where isInterval == true:
            mail.selectSpecialMailbox(self, zelector: Zelector.sentMailbox)
        case "u":
            if self.className == Clazz.SingleMessageViewer.rawValue {
                self.swizKeyDown(utils.getEvent(self, withKey: Codes.Wkey.get(), andFlags: Masks.Cmd.get()))
            } else {
                NSLog(self.className)
                self.swizKeyDown(utils.getEvent(self, withKey: Codes.Tab.get(), andFlags: Masks.Shift.get()))
                self.swizKeyDown(utils.getEvent(self, withKey: Codes.Tab.get(), andFlags: Masks.Shift.get()))
            }
        case "U":
            shorts.action(self, selector: Zelector.markAsUnread)
        case "v":
            mail.toMailbox(self, toAction: ToAction.Move)
        default:
            swizKeyDown(event)
        }
    }
}
