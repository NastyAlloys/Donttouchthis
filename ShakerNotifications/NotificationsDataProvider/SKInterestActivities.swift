//
//  SKProfileActivities.swift
//  ShakerNotifications
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import SwiftyJSON
import UIKit

class SKInterestActivities: SKBaseActivities {
    
    private(set) var interest_id: String? = ""
    private(set) var text: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.interest_id = json["body"]["id"].stringValue
        self.text = json["body"]["text"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
    }
    
    override var activityDescription: Lazy<NSAttributedString> {
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
                    var quoteText: String = text
                    
                    //  если текст новости больше 30 символов, то укорачиваем до 27 символов и добавляем троеточие
                    if text.characters.count > 30 {
                        let index = 27
                        quoteText = text.substringToIndex(text.startIndex.advancedBy(index))
                        let dot = "." as Character
                        quoteText += String(count: 3, repeatedValue: dot)
                    }
                    
                    let interestUrl = NSURL(string: "shaker://interest/\(self.interest_id!)")!
                    
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: quoteText,
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