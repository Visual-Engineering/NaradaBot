//
//  NaradaBotStyles.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 24/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

struct NaradaBotSyles {
    
    struct CardCellSyles {
        
        struct Insets {
            static let leftInsets: CGFloat = CGFloat(10)
            static let rightInsets: CGFloat = CGFloat(10)
            static let topInsets: CGFloat = CGFloat(10)
            static let bottomInsets: CGFloat = CGFloat(5)
        }
        
        static let prefferedCardSize = CGSize(width: UIScreen.main.bounds.width / 3.0, height: UIScreen.main.bounds.height / 3.0)
        
        static let buttonSize = CGSize(width: UIScreen.main.bounds.width / 6.0, height: UIScreen.main.bounds.height / 22.0)
        
        struct Fonts {
            static let title: UIFont = UIFont.systemFont(ofSize: 20)
            static let subtitle: UIFont = UIFont.systemFont(ofSize: 18)
            static let button: UIFont = UIFont.boldSystemFont(ofSize: 15)
        }
        
        struct Colors {
            static let title: UIColor = UIColor.lightGray
            static let subtitle: UIColor = UIColor.lightGray
            static let buttonText: UIColor = UIColor.black
            static let buttonBackground: UIColor = UIColor.lightGray
            static let buttonBorder: UIColor = UIColor.lightGray
            static let gradientTopColor: UIColor = UIColor.black
            static let gradientBottomColor: UIColor = UIColor.clear
        }
    }
}
