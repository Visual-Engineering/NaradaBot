//
//  NaradaBotCollectionViewFlowLayout.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 24/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class NaradaBotCollectionViewFlowLayout: JSQMessagesCollectionViewFlowLayout {
    
    override func messageBubbleSizeForItem(at indexPath: IndexPath!) -> CGSize {
        guard let message = self.collectionView.dataSource.collectionView(self.collectionView, messageDataForItemAt: indexPath) as? ChatMessage else {
            return CGSize.zero
        }
        
        if message.isCard {
            return NaradaBotSyles.CardCellSyles.prefferedCardSize
        }
        
        return self.bubbleSizeCalculator.messageBubbleSize(for: message, at: indexPath, with: self)
    }
}
