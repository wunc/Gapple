//
// Created by Duncan DeVore on 12/11/15.
// Copyright (c) 2015 ___ironfish___. All rights reserved.
//

import Cocoa
import Foundation

enum Clazz:String {
  case MailTableView, MessageListController, MessageViewer, MessageViewController, SingleMessageViewer
}

enum Zelector {
  case _primaryMailboxes, accountRelativePath, accounts, Archive, archiveMessages, children, displayName, draftsMailbox,
       deleteMessages, extendedDisplayName, favoritesBarView, Flagged, forwardMessage, inbox, junkMailbox, keyDown,
       markAsJunkMail, mailboxes, mailboxesController, mailboxName, markAsNotJunkMail, markAsRead, markAsUnread,
       messageViewers, moveMessage, name, openMessages, replyMessage, replyAllMessage, sentMailbox,
       setSelectedMailboxes, showComposeWindow, smartMailboxes, swizKeyDown, toggleFlag, trashMailbox
  func get() -> Selector {
    switch self {
    case .archiveMessages, .deleteMessages, .forwardMessage, .keyDown, .markAsJunkMail, .markAsNotJunkMail, .markAsRead,
         .markAsUnread, .moveMessage, .openMessages, .replyMessage, .replyAllMessage, .setSelectedMailboxes,
         .showComposeWindow, .swizKeyDown, .toggleFlag:
      return Selector("\(self):")
    case ._primaryMailboxes, .accountRelativePath, .accounts, .Archive, .children, .displayName, .draftsMailbox,
         .extendedDisplayName, .favoritesBarView, .Flagged, .inbox, .junkMailbox, .mailboxes, .mailboxesController,
         .mailboxName, .messageViewers, .name, .sentMailbox, .smartMailboxes, .trashMailbox:
      return Selector("\(self)")
    }
  }
}

class Utils {

  static let instance = Utils.init()

  init() {}

  func dispatchOnce(_ sender: AnyClass, clazz: Clazz) {
    let cls: AnyClass = NSClassFromString(clazz.rawValue)!
    let origSelector = Zelector.keyDown.get()
    let swizSelector = Zelector.swizKeyDown.get()
    let origMethod = class_getInstanceMethod(cls, origSelector)
    let swizMethod = class_getInstanceMethod(sender, swizSelector)
    class_addMethod(cls, swizSelector, method_getImplementation(origMethod!), method_getTypeEncoding(origMethod!))
    class_replaceMethod(cls, origSelector, method_getImplementation(swizMethod!), method_getTypeEncoding(swizMethod!))
    NSLog(clazz.rawValue + " Initialized")
  }

  func getChar(_ event:NSEvent) -> String {
    let chars: String = event.charactersIgnoringModifiers!
    return String(chars[...chars.startIndex])
  }

  func getEvent(_ sender:NSObject, withKey key:UInt16, andFlags flags:CGEventFlags? = nil) -> NSEvent! {
    sender.eventDate = nil
    let cgEventRef: CGEvent = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true)!
    if flags != nil {
      cgEventRef.flags = flags!
    }
    let nsEvent: NSEvent! = NSEvent(cgEvent: cgEventRef)
    return nsEvent
  }

  func getUnretainedObject(_ sender: AnyObject, selector: Selector) -> AnyObject {
    return sender.perform(selector, with: nil).takeUnretainedValue()
  }

  func getUnretainedObjectAsArray(_ sender: AnyObject, selector: Selector) -> Array<AnyObject> {
    return sender.perform(selector, with: nil).takeUnretainedValue() as! Array<AnyObject>
  }

  func getUnretainedObjectAsString(_ sender: AnyObject, selector: Selector) -> String {
    return sender.perform(selector, with: nil).takeUnretainedValue() as! String
  }
}
