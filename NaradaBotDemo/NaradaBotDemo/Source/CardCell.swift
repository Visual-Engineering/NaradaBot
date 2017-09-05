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
        label.textColor = NaradaBotSyles.CardCellSyles.Colors.title
        label.backgroundColor = UIColor.clear
        label.font = NaradaBotSyles.CardCellSyles.Fonts.title
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = NaradaBotSyles.CardCellSyles.Colors.subtitle
        label.backgroundColor = UIColor.clear
        label.font = NaradaBotSyles.CardCellSyles.Fonts.subtitle
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(NaradaBotSyles.CardCellSyles.Colors.buttonText, for: .normal)
        button.backgroundColor = NaradaBotSyles.CardCellSyles.Colors.buttonBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = NaradaBotSyles.CardCellSyles.Fonts.button
        return button
    }()
    
    let mediaContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientView: GradientBackground = {
        let view = GradientBackground(colorTop: NaradaBotSyles.CardCellSyles.Colors.gradientTopColor, colorBottom: NaradaBotSyles.CardCellSyles.Colors.gradientBottomColor)
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
        self.imageView.sd_setImage(with: URL(string: image), placeholderImage: nil)
        self.button.setTitle(buttonName, for: .normal)
        self.button.addTarget(self, action: #selector(self.buttonPressed(button:)) , for: .touchUpInside)
        self.actionLink = action
        self.setupMediaContainerView(leftMargin: leftMargin, rightMargin: rightMargin)
    }
    
    @objc func buttonPressed(button: UIButton) {
        guard let action = actionLink, let title = titleLabel.text, let subtitle = subtitleLabel.text, let image = imageView.image else {
            return
        }
        self.delegate?.buttonPressed(title: title, subtitle: subtitle, image: image, action: action)
    }
    
    //MARK: - Private API
    private func setupMediaContainerView(leftMargin: CGFloat, rightMargin: CGFloat) {
        
        self.contentView.addSubview(mediaContainer)
        NSLayoutConstraint.activate([
            mediaContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mediaContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mediaContainer.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: leftMargin),
            mediaContainer.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: rightMargin)
            ]
        )
        
        mediaContainer.addSubview(imageView)
        mediaContainer.addSubview(gradientView)
        mediaContainer.addSubview(titleLabel)
        mediaContainer.addSubview(subtitleLabel)
        mediaContainer.addSubview(button)
        
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: mediaContainer.topAnchor, constant: NaradaBotSyles.CardCellSyles.Insets.topInsets),
             titleLabel.leftAnchor.constraint(equalTo: mediaContainer.leftAnchor, constant: NaradaBotSyles.CardCellSyles.Insets.leftInsets),
             
             subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
             subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
             
             imageView.topAnchor.constraint(equalTo: mediaContainer.topAnchor),
             imageView.leftAnchor.constraint(equalTo: mediaContainer.leftAnchor),
             imageView.rightAnchor.constraint(equalTo: mediaContainer.rightAnchor),
             imageView.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor),
             
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.borderColor = NaradaBotSyles.CardCellSyles.Colors.buttonBorder.cgColor
        button.layer.borderWidth = NaradaBotSyles.CardCellSyles.buttonBorderWidth
        button.layer.cornerRadius = button.bounds.size.height / 2.0
    }
}
