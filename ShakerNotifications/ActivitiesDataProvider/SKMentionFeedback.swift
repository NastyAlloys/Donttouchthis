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
    Class, отвечающий за нотификации по упоминанием меня в публикацияъ/комментах
*/
class SKMentionFeedback: SKBaseFeedback {
    
    private(set) var id: String? = ""
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    private(set) var text: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var comment_text: String? = ""
    private(set) var address: String? = ""
    
}

class SKMentionPublicationFeedback: SKMentionFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.text = json["body"]["text"].stringValue
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " упомянул(а) вас в публикации "))
/*                // TODO URL PUBLICATION
                let publicationUrl = NSURL(string: "shaker://user/\(self.id)")!
                userAttributedString.appendAttributedString(
                    NSAttributedString(string: self.text!,
                        attributes: [
                            NSLinkAttributeName : publicationUrl,
                            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                        ]
                    )
                )
*/
                return userAttributedString
            }
        }
    }
}

class SKMentionCommentFeedback: SKMentionFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " упомянул(а) вас в комментарии: "))
/*                // TODO URL COMMENT
                let commentUrl = NSURL(string: "shaker://user/\(self.id)")!
                userAttributedString.appendAttributedString(
                    NSAttributedString(string: self.comment_text!,
                        attributes: [
                            NSLinkAttributeName : commentUrl,
                            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                        ]
                    )
                )
*/                
                userAttributedString.appendAttributedString(NSAttributedString(string: " к шейку в "))
                
                // генерируем кликабельную строку с адресом
                guard let addressString = self.address else { return userAttributedString }
                // TODO URL SHAKE
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