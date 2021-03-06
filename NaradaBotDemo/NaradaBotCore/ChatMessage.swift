//
//  ChatMessage.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 22/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatMessage: NSObject, JSQMessageData {
    
    //MARK: - Stored properties
    var text_: String
    var senderId_: String
    var senderDisplayName_: String
    var date_: NSDate?
    var isMediaMessage_: Bool = false
    var isCard: Bool = false
    var title: String?
    var subtitle: String?
    var image: String?
    var buttonName: String?
    var action: String?
    var productId: Int?
    
    //MARK: - Initializers
    init(senderId: String, displayName: String, text: String = "", title: String?, subtitle: String?, image: String?, action: String?, buttonName: String?, productId: Int?, date: NSDate?) {
        self.text_ = text
        self.senderId_ = senderId
        self.senderDisplayName_ = displayName
        self.date_ = date
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.action = action
        self.buttonName = buttonName
        self.productId = productId
        self.isCard = (title != nil && subtitle != nil && image != nil && action != nil && buttonName != nil && productId != nil)
    }
    
    init(senderId: String, displayName: String, text: String = "", date: NSDate?) {
        self.text_ = text
        self.senderId_ = senderId
        self.senderDisplayName_ = displayName
        self.date_ = date
        self.isCard = false
    }
    
    //MARK: - Public API
    func text() -> String! {
        return text_
    }
    
    func senderId() -> String! {
        return senderId_
    }
    
    func senderDisplayName() -> String! {
        return senderDisplayName_
    }
    
    func date() -> Date? {
        return date_ as Date?
    }
    
    func isMediaMessage() -> Bool {
        return isMediaMessage_
    }
    
    func messageHash() -> UInt {
        return UInt(self.hash)
    }
}

 public struct CardMessageStruct {
    public let title: String?
    public let subtitle: String?
    public let image: String?
    public let productId: Int?
    public let action: String?
}

extension CardMessageStruct {
    init(fromChatMessage chatMessage: ChatMessage) {
        self.title = chatMessage.title
        self.subtitle = chatMessage.subtitle
        self.image = chatMessage.image
        self.productId = chatMessage.productId
        self.action = chatMessage.action
    }
}
