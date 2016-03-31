//
//  SKRepostFeedbacks.swift
//  ShakerFeedbacks
//
//  Created by Andrey Egorov on 24.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import SwiftyJSON
import UIKit

/*
    Class, отвечающий за нотификации по моим репостам
*/
class SKRepostFeedback: SKBaseFeedback {
    
    private(set) var id: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    private(set) var text: String? = ""
    private(set) var is_repost: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.text = json["body"]["text"].stringValue
        self.is_repost = json["body"]["is_repost"].boolValue
    }
}

class SKRepostPublicationFeedback: SKRepostFeedback {
    
//    required init(json: JSON) {
//        super.init(json: json)
//        
//        self.id = json["body"]["id"].stringValue
//        self.photos = json["body"]["photos"].arrayObject as? [String]
//        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
//        self.count = json["body"]["count"].intValue
//        self.is_mine = json["body"]["is_mine"].boolValue
//        self.text = json["body"]["text"].stringValue
//        self.is_repost = json["body"]["is_repost"].boolValue
//    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                let userAttributedString = NSMutableAttributedString()
                
                let ownerUrl = NSURL(string: "shaker://user/\(self.user_ids[0])")!
                userAttributedString.appendAttributedString(
                    NSAttributedString(string: self.user_names[0],
                        attributes: [
                            NSLinkAttributeName : ownerUrl,
                            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                        ]
                    )
                )
                
                if (self.is_repost == true) {
                    userAttributedString.appendAttributedString(NSAttributedString(string: " поделился(ась) вашим репостом"))
                } else {
                    userAttributedString.appendAttributedString(NSAttributedString(string: " поделился(ась) вашей публикацией "))
                    
                    if let text = self.text {
                        let pubText: String = text.substringToCharactersCount(charactersCount: 30)
                        // TODO URL PUBLICATION
                        let quoteUrl = NSURL(string: "shaker://quote/\(self.id!)")!
                        userAttributedString.appendAttributedString(
                            NSAttributedString(string: pubText,
                                attributes: [
                                    NSLinkAttributeName : quoteUrl,
                                    NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                                ]
                            )
                        )
                    }
                }
                
                return userAttributedString
            }
        }
    }
}

class SKRepostQuoteFeedback: SKRepostFeedback {
        
//    required init(json: JSON) {
//        super.init(json: json)
//
//        self.id = json["body"]["id"].stringValue
//        self.count = json["body"]["count"].intValue
//        self.is_mine = json["body"]["is_mine"].boolValue
//        self.text = json["body"]["text"].stringValue
//    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                let userAttributedString = NSMutableAttributedString()
                
                let ownerUrl = NSURL(string: "shaker://user/\(self.user_ids[0])")!
                userAttributedString.appendAttributedString(
                    NSAttributedString(string: self.user_names[0],
                        attributes: [
                            NSLinkAttributeName : ownerUrl,
                            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                        ]
                    )
                )
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " поделился(ась) вашей цитатой "))
                
                if let text = self.text {
                    let quoteText: String = text.substringToCharactersCount(charactersCount: 30)
                    // TODO URL QUOTE
                    let quoteUrl = NSURL(string: "shaker://quote/\(self.id!)")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: quoteText,
                            attributes: [
                                NSLinkAttributeName : quoteUrl,
                                NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                            ]
                        )
                    )
                }
                
                return userAttributedString
            }
        }
    }
}