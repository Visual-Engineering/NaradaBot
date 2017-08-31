//
//  ChatViewController.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 24/07/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController, ApiAIChatDelegate, CardCellDelegate {
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    var messages = [ChatMessage]()
    var apiAIManager = ApiAIManager.shared
    
    //MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "User"
        self.senderDisplayName = "User"
        self.title = apiAIManager.senderID
        apiAIManager.delegate = self
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.collectionViewLayout = NaradaBotCollectionViewFlowLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - CollectionViewDataSourceDelegate
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.item]
        
        if let msg = message.title, let sbt = message.subtitle, let img = message.image,
            let action = message.action, let buttonName = message.buttonName {            
            let layout = collectionView.collectionViewLayout as! NaradaBotCollectionViewFlowLayout
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
            cell.configure(view: self, title: msg, subtitle: sbt, image: img, action: action, buttonName: buttonName, leftMargin: layout.messageBubbleLeftRightMargin, rightMargin: -layout.messageBubbleLeftRightMargin)
            return cell
            
        } else {
            let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
            if message.senderId() == senderId {
                cell.textView?.textColor = UIColor.black
            } else {
                cell.textView?.textColor = UIColor.white
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    //MARK: - MessageBubbles
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func addMessage(senderId: String, text: String) {
        let message = ChatMessage(senderId: senderId, displayName: senderDisplayName, text: text, date: NSDate())
        messages.append(message)
    }
    
    private func addCardMessage(senderId: String, title: String, subtitle: String, image: String, action: String, buttonName: String) {
        let message = ChatMessage(senderId: senderId, displayName: senderDisplayName, title: title, subtitle: subtitle, image: image, action: action, buttonName: buttonName, date: NSDate())
        messages.append(message)
    }
    
    //MARK: - Send message
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        self.addMessage(senderId: senderId, text: text)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        apiAIManager.createTextRequest(text: text)
    }
    
    //MARK: - Accessory button
    override func didPressAccessoryButton(_ sender: UIButton) {
        return
    }
    
    //MARK: - Private API
    
    //MARK: - ApiAIChatDelegate
    func addMessageFromApi(senderID: String, text: String) {
        self.addMessage(senderId: senderID, text: text)
        self.finishReceivingMessage()
    }
    
    func addCardFromApi(senderID: String, title: String, subtitle: String, image: String, action: String, buttonName: String) {
        self.addCardMessage(senderId: senderID, title: title, subtitle: subtitle, image: image, action: action, buttonName: buttonName)
        self.finishReceivingMessage()
    }
    
    //MARK: - CardCellDelegate
    func buttonPressed(action: String) {
        guard let url = URL(string: action) else {
            print("Error opening webview - wrong URL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
