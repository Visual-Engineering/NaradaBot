//
//  ProductViewController.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 31/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    //MARK: - Stored properties
    let mediaContainer: UIView = {
        let mediaContainer = UIView()
        mediaContainer.backgroundColor = UIColor.clear
        mediaContainer.translatesAutoresizingMaskIntoConstraints = false
        return mediaContainer
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 18)
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
    
    let extraInfo: UITextView = {
        let extraInfo = UITextView()
        extraInfo.translatesAutoresizingMaskIntoConstraints = false
        extraInfo.backgroundColor = UIColor.clear
        extraInfo.textColor = UIColor.lightGray
        extraInfo.font = UIFont.italicSystemFont(ofSize: 16)
        extraInfo.isUserInteractionEnabled = false
        return extraInfo
    }()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        setupView()
    }
    
    //MARK: - Public API
    func fillTheView(title: String, subtitle: String, image: UIImage, littleText: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
        extraInfo.text = littleText
    }
    
    //MARK: - Private API
    private func setupView() {
        self.mediaContainer.addSubview(titleLabel)
        self.mediaContainer.addSubview(subtitleLabel)
        self.mediaContainer.addSubview(imageView)
        self.mediaContainer.addSubview(extraInfo)
        self.view.addSubview(mediaContainer)
        
        NSLayoutConstraint.activate([mediaContainer.topAnchor.constraint(equalTo: view.topAnchor,   constant: 20),
                                     mediaContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     mediaContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                     mediaContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                                     
                                     titleLabel.topAnchor.constraint(equalTo: mediaContainer.topAnchor, constant: 10),
                                     titleLabel.leftAnchor.constraint(equalTo: mediaContainer.leftAnchor, constant: 20),
                                     
                                     subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
                                     subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                                     
                                     imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
                                     imageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
                                     imageView.rightAnchor.constraint(equalTo: mediaContainer.rightAnchor, constant: -20),
                                     imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3.0),
                                     
                                     extraInfo.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                                     extraInfo.bottomAnchor.constraint(equalTo: mediaContainer.bottomAnchor, constant: -10),
                                     extraInfo.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
                                     extraInfo.rightAnchor.constraint(equalTo: imageView.rightAnchor)])
    }
}
