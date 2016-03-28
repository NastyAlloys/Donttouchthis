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
    Class, отвечающий за комментарии к моим в цитатам/публикациям/шейкам
*/
class SKCommentFeedback: SKBaseFeedback {
    
    private(set) var id: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    private(set) var text: String? = ""
    private(set) var comment_text: String? = ""
    private(set) var address: String? = ""
    
}

class SKCommentQuoteFeedback: SKCommentFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.text = json["body"]["text"].stringValue
        self.comment_text = json["body"]["comment_text"].stringValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                // генерируем строку пользователей, которым понравилась цитата
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " оставил(а) комментарий: "))
                
                if let commentText = self.comment_text {
                    let commentText: String = commentText.substringToCharactersCount(charactersCount: 30)
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: commentText)
                    )
                }
                
                let text = " к Вашей цитате "
                userAttributedString.appendAttributedString(NSAttributedString(string: text))
                
                
                if let text = self.text {
                    let quoteText: String = text.substringToCharactersCount(charactersCount: 30)

                    // TODO URL QUOTE
                    let url = NSURL(string: "shaker://quote/\(self.id!)")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: quoteText,
                            attributes: [
                                NSLinkAttributeName : url,
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

class SKCommentPublicationFeedback: SKCommentFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.text = json["body"]["text"].stringValue
        self.comment_text = json["body"]["comment_text"].stringValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                // генерируем строку пользователей, которым понравилась цитата
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " оставил(а) комментарий: "))
                
                if let commentText = self.comment_text {
                    let commentText: String = commentText.substringToCharactersCount(charactersCount: 30)
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: commentText)
                    )
                }
                
                let text = " к Вашей публикации "
                userAttributedString.appendAttributedString(NSAttributedString(string: text))
                
                if let text = self.text {
//                    let pubText: String = text.substringToCharactersCount(charactersCount: 30)
                    let pubText = text
                    // TODO URL PUBLICATION
                    let pubUrl = NSURL(string: "shaker://quote/\(self.id!)")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: pubText,
                            attributes: [
                                NSLinkAttributeName : pubUrl,
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

class SKCommentShakeFeedback: SKCommentFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.comment_text = json["body"]["comment_text"].stringValue
        self.address = json["body"]["address"].stringValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                // генерируем строку пользователей, которым понравилась цитата
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " оставил(а) комментарий: "))
                
                if let commentText = self.comment_text {
                    let commentText: String = commentText.substringToCharactersCount(charactersCount: 30)
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: commentText)
                    )
                }
                
                let text = " к Вашему шейку в "
                userAttributedString.appendAttributedString(NSAttributedString(string: text))
                
                // генерируем кликабельную строку с адресом
                guard let addressString = self.address else { return userAttributedString }
                // TODO URL SHAKE ADDRESS
                let url : NSString = "https://google.com/\(self.address)"
                let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                let searchURL : NSURL = NSURL(string: urlStr)!
                
                userAttributedString.appendAttributedString(NSAttributedString(string: addressString,
                    attributes: [
                        NSLinkAttributeName : searchURL,
                        NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                    ])
                )
                
                return userAttributedString
            }
        }
    }
}