//
//  ApiAIManager.swift
//  NaradaBot
//
//  Created by Margareta Kusan on 25/07/2017.
//  Copyright © 2017 Margareta Kusan. All rights reserved.
//

import Foundation
import VisualEnginApiAI

public protocol ApiAIChatDelegate {
    func addMessageFromApi(senderID: String, text: String)
    func addCardFromApi(senderID: String, title: String, subtitle: String, image: String, action: String, buttonName: String, productId: Int)
}

public class ApiAIManager {
    
    //MARK: - Stored properties
    static let shared = ApiAIManager()
    var delegate: ApiAIChatDelegate?
    public var senderID = "NaradaBot" //by default NaradaBot, but should be set different for every bot
    
    //MARK: - Initializers
    private init() {}
    
    //MARK: - Public API
    func createTextRequest(text: String) {
        let request = ApiAI.shared().textRequest()
        request?.query = text
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            print(response.debugDescription)
            self.processResponse(response: response)
        }, failure: { (request, error) in
            self.addErrorMessage()
        })
        ApiAI.shared().enqueue(request)
    }
    
    //MARK: - Private API
    private func processResponse(response: AIResponse)  {
        
        guard statusCodeValid(statusCode: response.status.code) else {
            self.addErrorMessage()
            return
        }
        
        if let messages = response.result.fulfillment.messages as? [Dictionary<String, AnyObject>] {
            messages.forEach({ (message) in
                if let textInMessage = message["speech"] as? String {
                    self.delegate?.addMessageFromApi(senderID: senderID, text: textInMessage)
                }
            })
        }
        
        guard let data = response.result.fulfillment.data else { return }
        if let results = data["results"] as? Array<Dictionary<String, AnyObject>> {
            for result in results {
                if let name: String = result["title"] as? String,
                    let subtitle = result["subtitle"] as? String,
                    let image: String = result["image"] as? String,
                    let action: String = result["action"] as? String,
                    let buttonName: String = result["button"] as? String,
                    let id = result["id"]?.int64Value
                {
                    self.delegate?.addCardFromApi(senderID: senderID, title: name, subtitle: subtitle, image: image, action: action, buttonName: buttonName, productId: Int(id))
                }
            }
        }
    }
    
    private func addErrorMessage() {
        self.delegate?.addMessageFromApi(senderID: senderID, text: "We are having some issues, please try again later!")
    }
    
    //MARK: - Webhook
    private func statusCodeValid(statusCode: Int) -> Bool {
        switch statusCode {
        case 400:
            print("Bad Request – The request was invalid or cannot be served")
        case 401:
            print("Unauthorized – The request requires user authentication")
        case 403:
            print("Forbidden – The server understood the request but refuses to take any further action or the access is not allowed")
        case 404:
            print("Not found – There is no resource behind the URI")
        case 500:
            print("Server fault – Internal Server Error")
        case 503:
            print("Service Unavailable – Internal Server Error")
        case 206:
            print("Webhook call failed. Error: 400 Bad Request")
        default:
            return true
        }
        
        self.addErrorMessage()
        return false
    }
}
