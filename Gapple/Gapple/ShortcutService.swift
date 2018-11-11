//
// Created by Duncan DeVore on 12/4/15.
// Copyright (c) 2015 ___ironfish___. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

enum Masks {
  case AltCmd, Cmd, Shift
  func get() -> CGEventFlags {
    switch self {
      case .AltCmd:
        return CGEventFlags(rawValue: CGEventFlags.maskAlternate.rawValue | CGEventFlags.maskCommand.rawValue)
      case .Cmd:
        return CGEventFlags.maskCommand
      case .Shift:
        return CGEventFlags.maskShift
    }
  }
}

enum Codes {
  case ArrowDn, ArrowLf, ArrowRt, ArrowUp, FKey, Tab, Wkey
  func get() -> UInt16 {
    switch self {
      case .ArrowDn:
        return 125
      case .ArrowLf:
        return 123
      case .ArrowRt:
        return 124
      case .ArrowUp:
        return 126
      case .FKey:
        return 3
      case .Tab:
        return 0x30
      case .Wkey:
        return 0x0D
    }
  }
}

struct Shortcut {
    let name: String
    let desc: String

    init(name: String, withDesc desc: String) {
      self.name = name
      self.desc = desc
    }
}

class ShortcutService {

  static let instance = ShortcutService.init()

  let ShortcutDict:[String:Shortcut]

  init() {
    ShortcutDict = [
        "!":  Shortcut(name: "          !: ", withDesc: "Mark as junk"),
        "^!": Shortcut(name: "         ^!: ", withDesc: "Mark not as junk"),
        "#":  Shortcut(name: "          #: ", withDesc: "Delete message"),
        "?":  Shortcut(name: "          ?: ", withDesc: "Open Keyboard shortcut help"),
        "/":  Shortcut(name: "          /: ", withDesc: "Search mailbox/message"),
        "a":  Shortcut(name: "          a: ", withDesc: "Reply all"),
        "c":  Shortcut(name: "          c: ", withDesc: "Compose message"),
        "e":  Shortcut(name: "          e: ", withDesc: "Archive message"),
        "f":  Shortcut(name: "          f: ", withDesc: "Forward message"),
        "ga": Shortcut(name: "   g then a: ", withDesc: "Go to Archive"),
        "gc": Shortcut(name: "   g then c: ", withDesc: "Go to Contacts"),
        "gd": Shortcut(name: "   g then d: ", withDesc: "Go to Drafts"),
        "gi": Shortcut(name: "   g then i: ", withDesc: "Go to Inbox"),
        "gl": Shortcut(name: "   g then l: ", withDesc: "Go to Label"),
        "gs": Shortcut(name: "   g then s: ", withDesc: "Go to Starred"),
        "gt": Shortcut(name: "   g then t: ", withDesc: "Go to Sent"),
        "I":  Shortcut(name: "<shift> + i: ", withDesc: "Mark as read"),
        "j":  Shortcut(name: "          j: ", withDesc: "Older conversation"),
        "J":  Shortcut(name: "<shift> + j: ", withDesc: "Older conversation select"),
        "k":  Shortcut(name: "          k: ", withDesc: "Newer conversation"),
        "K":  Shortcut(name: "<shift> + k: ", withDesc: "Newer conversation select"),
        "l":  Shortcut(name: "          l: ", withDesc: "Open \"copy to\" menu"),
        "n":  Shortcut(name: "          n: ", withDesc: "Read next message"),
        "o":  Shortcut(name: "          o: ", withDesc: "Open message"),
        "p":  Shortcut(name: "          p: ", withDesc: "Read previous message"),
        "r":  Shortcut(name: "          r: ", withDesc: "Reply"),
        "s":  Shortcut(name: "          s: ", withDesc: "Toggle flag"),
        "u":  Shortcut(name: "          u: ", withDesc: "Back to threadlist"),
        "U":  Shortcut(name: "<shift> + u: ", withDesc: "Mark as unread"),
        "v":  Shortcut(name: "          v: ", withDesc: "Open \"move to\" menu"),
        "y":  Shortcut(name: "          y: ", withDesc: "Archive message")
    ]
  }

  func getShortcuts() -> String {
    var shorts: String = ""
    let sortedKeys = Array(ShortcutDict.keys).sorted(by: <)
    for key in sortedKeys {
      let shortcut = ShortcutDict[key]
      shorts += shortcut!.name + shortcut!.desc + "\n"
    }
    shorts += "---------------------------------------\n"
    shorts += "NOTE: u works only for open messages\n"
    shorts += "NOTE: ^ = Control Key"
    return shorts
  }

//  func getShortcuts2() -> String {
//    var shorts: String = "------------ Navigation ------------\n"
//    shorts = shorts + getShortcut("ga")!.name + getShortcut("ga")!.desc + "\n"
//    shorts = shorts + getShortcut("gc")!.name + getShortcut("gc")!.desc + "\n"
//    shorts = shorts + getShortcut("gd")!.name + getShortcut("gd")!.desc + "\n"
//    shorts = shorts + getShortcut("gi")!.name + getShortcut("gi")!.desc + "\n"
//    shorts = shorts + getShortcut("gl")!.name + getShortcut("gl")!.desc + "\n"
//    shorts = shorts + getShortcut("gs")!.name + getShortcut("gs")!.desc + "\n"
//    shorts = shorts + getShortcut("gt")!.name + getShortcut("gt")!.desc + "\n"
//    shorts = shorts + getShortcut("j")!.name + getShortcut("j")!.desc + "\n"
//    shorts = shorts + getShortcut("J")!.name + getShortcut("J")!.desc + "\n"
//    shorts = shorts + getShortcut("k")!.name + getShortcut("k")!.desc + "\n"
//    shorts = shorts + getShortcut("K")!.name + getShortcut("K")!.desc + "\n"
//    shorts = shorts + getShortcut("u")!.name + getShortcut("u")!.desc + "\n"
//    shorts = shorts + "\n------------ Search ----------------\n"
//    shorts = shorts + getShortcut("/")!.name + getShortcut("/")!.desc + "\n"
//    shorts = shorts + getShortcut("^/")!.name + getShortcut("^/")!.desc + "\n"
//    shorts = shorts + "\n------------ Actions ---------------\n"
//    shorts = shorts + getShortcut("!")!.name + getShortcut("!")!.desc + "\n"
//    shorts = shorts + getShortcut("^!")!.name + getShortcut("^!")!.desc + "\n"
//    shorts = shorts + getShortcut("#")!.name + getShortcut("#")!.desc + "\n"
//    shorts = shorts + getShortcut("?")!.name + getShortcut("?")!.desc + "\n"
//    shorts = shorts + getShortcut("c")!.name + getShortcut("c")!.desc + "\n"
//    shorts = shorts + getShortcut("e")!.name + getShortcut("e")!.desc + "\n"
//    shorts = shorts + getShortcut("y")!.name + getShortcut("y")!.desc + "\n"
//    shorts = shorts + getShortcut("f")!.name + getShortcut("f")!.desc + "\n"
//    shorts = shorts + getShortcut("o")!.name + getShortcut("o")!.desc + "\n"
//    shorts = shorts + getShortcut("r")!.name + getShortcut("r")!.desc + "\n"
//    shorts = shorts + getShortcut("a")!.name + getShortcut("a")!.desc + "\n"
//    shorts = shorts + getShortcut("I")!.name + getShortcut("I")!.desc + "\n"
//    shorts = shorts + getShortcut("s")!.name + getShortcut("s")!.desc + "\n"
//    shorts = shorts + getShortcut("U")!.name + getShortcut("U")!.desc + "\n"
//    shorts = shorts + getShortcut("l")!.name + getShortcut("l")!.desc + "\n"
//    shorts = shorts + getShortcut("v")!.name + getShortcut("v")!.desc + "\n"
//    shorts = shorts + "\n"
//    shorts = shorts + "NOTE: u works only for open messages\n"
//    shorts = shorts + "NOTE: ^ = Control Key"
//    return shorts
//  }

  func shortcutsAlert(_ sender:NSObject) {
    sender.eventDate = nil
    let alert:NSAlert = NSAlert()
    let views:[AnyObject] = alert.window.contentView!.subviews
    let informativeTextFont: NSFont = NSFont(name: "Menlo", size: 12.0)!
    let messageTextFont: NSFont = NSFont(name: "Arial", size: 16.0)!
    (views[4] as! NSTextField).font = messageTextFont
    (views[5] as! NSTextField).font = informativeTextFont
    alert.messageText = "Keyboard Shortcuts"
    alert.informativeText = getShortcuts()
    alert.addButton(withTitle: NSLocalizedString("Close", comment:""))
    alert.beginSheetModal(for: NSApplication.shared.mainWindow!) {
      responseCode in
      if NSApplication.ModalResponse.alertFirstButtonReturn == responseCode {
        NSLog("FirstButton")
      }
    }
  }

  func action(_ sender:NSObject, selector: Zelector) {
    sender.eventDate = nil
    switch selector {
      case .archiveMessages:
        sender.perform(Zelector.archiveMessages.get(), with: nil)
      case .showComposeWindow:
        sender.perform(Zelector.showComposeWindow.get(), with: nil)
      case .deleteMessages:
        sender.perform(Zelector.deleteMessages.get(), with: nil)
      case .forwardMessage:
        sender.perform(Zelector.forwardMessage.get(), with: nil)
      case .markAsNotJunkMail:
        sender.perform(Zelector.markAsNotJunkMail.get(), with: nil)
      case .markAsJunkMail:
        sender.perform(Zelector.markAsJunkMail.get(), with: nil)
      case .openMessages:
        sender.perform(Zelector.openMessages.get(), with: nil)
      case .markAsRead:
        sender.perform(Zelector.markAsRead.get(), with: nil)
      case .replyMessage:
        sender.perform(Zelector.replyMessage.get(), with: nil)
      case .replyAllMessage:
        sender.perform(Zelector.replyAllMessage.get(), with: nil)
      case .toggleFlag:
        sender.perform(Zelector.toggleFlag.get(), with: nil)
      case .markAsUnread:
        sender.perform(Zelector.markAsUnread.get(), with: nil)
      default:
        NSLog("default")
    }
  }

  func getShortcut(key:String) -> Shortcut? {
    return self.ShortcutDict[key]
  }

  func intervalValid(date:NSDate?) -> Bool {
    if date == nil { return false }
    let timePassed = (date?.timeIntervalSinceNow)! * -1000.0
    return (timePassed < 500) ? true : false
  }
}
