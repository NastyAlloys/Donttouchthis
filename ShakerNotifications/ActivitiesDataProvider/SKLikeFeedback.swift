//
//  SKLikeFeedback.swift
//  ShakerFeedbacks
//
//  Created by Andrey Egorov on 24.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import SwiftyJSON
import UIKit

/*
Class, отвечающий за лайки в нотификациях/активностях друзей по публикациям/шейкам/новостям/цитатам
*/
class SKLikeFeedback: SKBaseFeedback {
    
    private(set) var id: String? = ""
    private(set) var text: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    private(set) var address: String? = ""
    private(set) var is_repost: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.text = json["body"]["text"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
    }
}

class SKLikeInterestFeedback: SKLikeFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.text = json["body"]["text"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                
                // генерируем строку пользователей, которые подписались
                let userAttributedString = NSMutableAttributedString()
                let additionalUsers = self.user_others
                
                let usersString = self.generateSeparatedUserString(self.user_names, userIds: self.user_ids, userOthers: additionalUsers)
                userAttributedString.appendAttributedString(usersString)
                
                // дозаписываем в строку количество остальных пользователей
                if additionalUsers > 0 {
                    let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователям", form_for_5: " пользователей")
                    userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                }
                
                // генерируем связующий глагол и меняем его цвет
                let text = " нравится новость "
                let coloredText = self.setAttributedStringColor(text, color: UIColor.lightGrayColor())
                userAttributedString.appendAttributedString(coloredText)
                
                // генерируем ссылку на источник
                let interestSourceUrl = NSURL(string: "shaker://interestSource/\(self.owner_id)")!
                userAttributedString.appendAttributedString(
                    NSAttributedString(string: self.owner_name,
                        attributes: [
                            NSLinkAttributeName : interestSourceUrl,
                            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                        ]
                    )
                )
                
                // Добавляем пробел
                userAttributedString.appendAttributedString(NSAttributedString(string: " "))
                
                // генерируем ссылку на новость
                if let text = self.text {
                    let interestText: String = text.substringToCharactersCount(charactersCount: 30)
                    
                    let interestUrl = NSURL(string: "shaker://interest/\(self.id!)")!
                    
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: interestText,
                            attributes: [
                                NSLinkAttributeName : interestUrl,
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


class SKLikeShakeFeedback: SKLikeFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.address = json["body"]["address"].stringValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                // генерируем строку пользователей, которые подписались
                let userAttributedString = NSMutableAttributedString()
                
                // если понравился мой шейк
                if self.is_mine == true {
                    let ownerUrl = NSURL(string: "shaker://user/\(self.user_ids[0])")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: self.user_names[0],
                            attributes: [
                                NSLinkAttributeName : ownerUrl,
                                NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                            ]
                        )
                    )
                    
                    let text = " нравится Ваш шейк в "
                    userAttributedString.appendAttributedString(NSAttributedString(string: text))
                } else {
                    let additionalUsers = self.user_others
                    
                    let usersString = self.generateSeparatedUserString(self.user_names, userIds: self.user_ids, userOthers: additionalUsers)
                    userAttributedString.appendAttributedString(usersString)
                    
                    // дозаписываем в строку количество остальных пользователей
                    if additionalUsers > 0 {
                        let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователя", form_for_5: " пользователей")
                        userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                    }
                    
                    // генерируем связующий глагол
                    let text = " нравится шейк в "
                    userAttributedString.appendAttributedString(NSAttributedString(string: text))
                }
                
                // генерируем кликабельную строку с адресом
                guard let addressString = self.address else { return userAttributedString }
                
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

class SKLikeQuoteFeedback: SKLikeFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.text = json["body"]["text"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                let userAttributedString = NSMutableAttributedString()
                
                if self.is_mine == true {
                    let ownerUrl = NSURL(string: "shaker://user/\(self.user_ids[0])")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: self.user_names[0],
                            attributes: [
                                NSLinkAttributeName : ownerUrl,
                                NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                            ]
                        )
                    )
                    
                    let text = " нравится Ваша цитата "
                    userAttributedString.appendAttributedString(NSAttributedString(string: text))
                    
                } else {
                    // генерируем строку пользователей, которым понравилась цитата
                    let additionalUsers = self.user_others
                    
                    let usersString = self.generateSeparatedUserString(self.user_names, userIds: self.user_ids, userOthers: additionalUsers)
                    userAttributedString.appendAttributedString(usersString)
                    
                    // дозаписываем в строку количество остальных пользователей
                    if additionalUsers > 0 {
                        let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователям", form_for_5: " пользователей")
                        userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                    }
                    
                    // генерируем связующий глагол и меняем его цвет
                    let text = " нравится цитата "
                    let coloredText = self.setAttributedStringColor(text, color: UIColor.lightGrayColor())
                    userAttributedString.appendAttributedString(coloredText)
                    
                    let ownerUrl = NSURL(string: "shaker://user/\(self.owner_id)")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: self.owner_name,
                            attributes: [
                                NSLinkAttributeName : ownerUrl,
                                NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                            ]
                        )
                    )
                    
                    // Добавляем пробел
                    userAttributedString.appendAttributedString(NSAttributedString(string: " "))
                }
                
                if let text = self.text {
                    let quoteText: String = text.substringToCharactersCount(charactersCount: 30)
                    
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

class SKLikePublicationFeedback: SKLikeFeedback {
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.is_repost = json["body"]["is_repost"].boolValue
        self.text = json["body"]["text"].stringValue
    }
    
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
                
                if self.is_mine == true {
                    if self.is_repost == true {
                        userAttributedString.appendAttributedString(NSAttributedString(string: " нравится Ваш репост публикации "))
                    } else {
                        userAttributedString.appendAttributedString(NSAttributedString(string: " нравится Ваша публикация "))
                    }
                    
                    if let text = self.text {
                        text.substringToCharactersCount(charactersCount: 30)
                        // TODO URL PUBLICATION
                        let url = NSURL(string: "shaker://quote/\(self.id!)")!
                        userAttributedString.appendAttributedString(
                            NSAttributedString(string: text,
                                attributes: [
                                    NSLinkAttributeName : url,
                                    NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                                ]
                            )
                        )
                    }
                    
                } else {
                    if self.with_photo > 0 {
                        let plurPubString = pluralize(self.count!, form_for_1: "публикация", form_for_2: "публикации", form_for_5: "публикаций")
                        userAttributedString.appendAttributedString(NSAttributedString(string: " нравится \(self.count!) \(plurPubString)"))
                    } else {
                        // генерируем строку пользователей, которым понравилась цитата
                        let additionalUsers = self.user_others
                        
                        let usersString = self.generateSeparatedUserString(self.user_names, userIds: self.user_ids, userOthers: additionalUsers)
                        userAttributedString.appendAttributedString(usersString)
                        
                        // дозаписываем в строку количество остальных пользователей
                        if additionalUsers > 0 {
                            let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователям", form_for_5: " пользователей")
                            userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                        }
                        
                        // генерируем связующий глагол и меняем его цвет
                        let text = " нравится публикация "
                        let coloredText = self.setAttributedStringColor(text, color: UIColor.lightGrayColor())
                        userAttributedString.appendAttributedString(coloredText)
                        
                        let ownerUrl = NSURL(string: "shaker://user/\(self.owner_id)")!
                        userAttributedString.appendAttributedString(
                            NSAttributedString(string: self.owner_name,
                                attributes: [
                                    NSLinkAttributeName : ownerUrl,
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