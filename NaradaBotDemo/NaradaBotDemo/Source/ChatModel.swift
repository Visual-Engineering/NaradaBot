//
//  ChatModel.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 05/09/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

class ChatModel {
    
    //MARK: - Stored properties
    public var messages = [ChatMessage]()
    static let shared = ChatModel()
    
    //MARK: - Initializers
    private init() {}
    
    //MARK: - Public API
    func getMessageById(id: Int) -> ChatMessage? {
        return messages.filter{ $0.productId != nil && $0.productId == id }.first
    }
}
