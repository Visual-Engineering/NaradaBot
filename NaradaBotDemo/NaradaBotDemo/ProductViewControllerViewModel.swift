//
//  ProductViewControllerViewModel.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 05/09/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

class ProductViewControllerViewModel {
    var littleText: String
    var cardMessage: ChatMessage
    
    init(cardMessage: ChatMessage, littleText: String) {
        self.littleText = littleText
        self.cardMessage = cardMessage
    }
}
