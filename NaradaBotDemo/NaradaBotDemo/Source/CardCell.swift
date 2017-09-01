//
//  CardCell.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 21/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardCellDelegate: class {
    func buttonPressed(title: String, subtitle: String, image: UIImage, action: String)
}

class CardCell: UICollectionViewCell {
    
    // MARK: - Stored properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.clear
        label.font = NaradaBotSyles.CardCellSyles.Fonts.title
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.clear
        label.font = NaradaBotSyles.CardCellSyles.Fonts.subtitle
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "gray"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let mediaContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientView: GradientBackground = {
        let view = GradientBackground()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var delegate: CardCellDelegate?
    var actionLink: String?
    
    //MARK: - Public API
    func configure(view: CardCellDelegate, title: String, subtitle: String, image: String, action: String, buttonName: String, leftMargin: CGFloat, rightMargin: CGFloat) {
        self.delegate = view
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.imageView.sd_setImage(with: URL(string: image), placeholderImage: #imageLiteral(resourceName: "hotelPlaceholder"))
        self.button.setTitle(buttonName, for: .normal)
        self.button.addTarget(self, action: #selector(self.buttonPressed(button:)) , for: .touchUpInside)
        self.actionLink = action
        self.setupMediaContainerView(leftMargin: leftMargin, rightMargin: rightMargin)
    }
    
    //MARK: - Private API
    @objc func buttonPressed(button: UIButton) {
        guard let action = actionLink, let title = titleLabel.text, let subtitle = subtitleLabel.text, let image = imageView.image else {
            return
        }
        self.delegate?.buttonPressed(title: title, subtitle: subtitle, image: image, action: action)
    }
    
    private func setupMediaContainerView(leftMargin: CGFloat, rightMargin: CGFloat) {
        
        self.contentView.addSubview(mediaContainer)
        NSLayoutConstraint.activate([
            mediaContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            mediaContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            mediaContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: leftMargin),
            mediaContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: rightMargin)
            ]
        )
        
        mediaContainer.addSubview(gradientView)
        mediaContainer.addSubview(titleLabel)
        mediaContainer.addSubview(subtitleLabel)
        mediaContainer.addSubview(imageView)
        mediaContainer.addSubview(button)
        
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: mediaContainer.topAnchor, constant: NaradaBotSyles.CardCellSyles.Insets.topInsets),
             titleLabel.leftAnchor.constraint(equalTo: mediaContainer.leftAnchor, constant: NaradaBotSyles.CardCellSyles.Insets.leftInsets),
             
             subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
             subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
             
             imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 0),
             imageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
             imageView.rightAnchor.constraint(equalTo: mediaContainer.rightAnchor, constant: -NaradaBotSyles.CardCellSyles.Insets.rightInsets),
             
             button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: NaradaBotSyles.CardCellSyles.Insets.bottomInsets),
             button.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor, constant: -NaradaBotSyles.CardCellSyles.Insets.bottomInsets),
             button.rightAnchor.constraint(equalTo: mediaContainer.rightAnchor, constant: -NaradaBotSyles.CardCellSyles.Insets.rightInsets),
             button.widthAnchor.constraint(equalToConstant: NaradaBotSyles.CardCellSyles.buttonSize.width),
             button.heightAnchor.constraint(equalToConstant: NaradaBotSyles.CardCellSyles.buttonSize.height),
             
             gradientView.topAnchor.constraint(equalTo: mediaContainer.topAnchor),
             gradientView.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor),
             gradientView.leftAnchor.constraint(equalTo: mediaContainer.leftAnchor),
             gradientView.rightAnchor.constraint(equalTo: mediaContainer.rightAnchor)
            ]
        )
    }
}
