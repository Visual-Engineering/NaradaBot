//
//  ChatViewController.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 24/07/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

protocol ChatViewControllerDelegate: class {
    /* Inherit this protocol delegate to get info from the card chosen by the user! */
    func elementChosen(chat: CardMessageStruct)
}

class ChatViewController: JSQMessagesViewController, ApiAIChatDelegate, CardCellDelegate {
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    var apiAIManager = ApiAIManager.shared
    var delegate: ChatViewControllerDelegate?
    var messages = [ChatMessage]()
    
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
        //collectionView.collectionViewLayout.sectionInset = UIEdgeInsetsMake(10, -20, 0, -20)
        self.navigationController?.navigationBar.isTranslucent = false
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
        if message.isCard {
            let layout = collectionView.collectionViewLayout as! NaradaBotCollectionViewFlowLayout
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
            cell.configure(view: self, message: message, leftMargin: layout.messageBubbleLeftRightMargin, rightMargin: -layout.messageBubbleLeftRightMargin)
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
    
    private func addCardMessage(senderId: String, title: String, subtitle: String, image: String, action: String, buttonName: String, productId: Int) {
        let message = ChatMessage(senderId: senderId, displayName: senderDisplayName, title: title, subtitle: subtitle, image: image, action: action, buttonName: buttonName, productId: productId, date: NSDate())
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
    
    //MARK: - ApiAIChatDelegate
    func addMessageFromApi(senderID: String, text: String) {
        self.addMessage(senderId: senderID, text: text)
        self.finishReceivingMessage()
    }
    
    func addCardFromApi(senderID: String, title: String, subtitle: String, image: String, action: String, buttonName: String, productId: Int) {
        self.addCardMessage(senderId: senderID, title: title, subtitle: subtitle, image: image, action: action, buttonName: buttonName, productId: productId)
        self.finishReceivingMessage()
    }
    
    //MARK: - CardCellDelegate
    func buttonPressed(productId: Int) {
        guard let message = getMessageById(id: productId) else {
            return
        }
        
        self.delegate?.elementChosen(chat: CardMessageStruct(fromChatMessage: message))
        
        /* //Uncomment the following lines to open the 'action' url in safari.
        guard let url = URL(string: action) else {
            print("Error opening webview - wrong URL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        */
    }
    
    //MARK: - Private API
    private func getMessageById(id: Int) -> ChatMessage? {
        return messages.filter{ $0.productId != nil && $0.productId == id }.first
    }
}
