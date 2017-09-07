//
//  ViewController.swift
//  NaradaBotDemo
//
//  Created by Margareta Kusan on 29/08/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import UIKit
import VisualEnginApiAI
import NaradaBotCore

class ViewController: UIViewController, ChatViewControllerDelegate {
    
    //MARK: - Stored properties
    var apiAI = ApiAI.shared()!
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Chat with NaradaBot!", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private API
    private func setupView() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.0), button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0), button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)])
        
        button.addTarget(self, action: #selector(startChatInterface), for: .touchUpInside)
    }
    
    //MARK: - Public API
    @objc func startChatInterface() {
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "c07c4bf3b1ac4c5ab6f7f2b0db180149" // this is developer access token different for each agent
        apiAI.configuration = configuration
        
        let chatInterface = ChatViewController()
        chatInterface.apiAIManager.senderID = "NaradaBot"
        chatInterface.delegate = self
        self.navigationController?.pushViewController(chatInterface, animated: true)
    }
    
    //MARK: - ChatViewControllerDelegate
    func elementChosen(chat message: CardMessageStruct) {
        
        let infoText = "Note: This is a screen example of the user picked card from the chat interface webhook results."
        
        let viewModel = ProductViewControllerViewModel(cardMessage: message, littleText: infoText)
        let productViewController = ProductViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(productViewController, animated: true)
    }
}
