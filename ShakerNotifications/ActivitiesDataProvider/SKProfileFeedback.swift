//
//  SKProfileFeedback.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

class SKProfileFeedback: SKBaseFeedback {
    
    private(set) var sub_user_ids: [String]? = []
    private(set) var sub_user_names: [String]? = []
    private(set) var sub_user_others: Int? = 0
    private(set) var includes_me: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.sub_user_ids = json["body"]["sub_user_ids"].arrayObject as? [String]
        self.sub_user_names = json["body"]["sub_user_names"].arrayObject as? [String]
        self.sub_user_others = json["body"]["sub_user_others"].intValue
        self.includes_me = json["body"]["includes_me"].boolValue
    }
    
    override var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                let userAttributedString = NSMutableAttributedString()
                
                if self.includes_me == true {
                    
                    let ownerUrl = NSURL(string: "shaker://user/\(self.user_ids[0])")!
                    userAttributedString.appendAttributedString(
                        NSAttributedString(string: self.user_names[0],
                            attributes: [
                                NSLinkAttributeName : ownerUrl,
                                NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                            ]
                        )
                    )
                    
                    let text = " подписался(ась) на вас"
                    userAttributedString.appendAttributedString(NSAttributedString(string: text))
                } else {
                    let additionalUsers = self.user_others
                    let subAdditionalUsers = self.sub_user_others
                    
                    // генерируем строку пользователей, которые подписались
                    let usersString = self.generateSeparatedUserString(self.user_names, userIds: self.user_ids, userOthers: additionalUsers)
                    userAttributedString.appendAttributedString(usersString)
                    
                    // дозаписываем в строку количество остальных пользователей
                    if additionalUsers > 0 {
                        let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователя", form_for_5: " пользователей")
                        userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                    }
                    
                    // генерируем связующий глагол
                    let actionString = pluralize(self.user_names.count, form_for_1: " подписался(ась) на ", form_for_2: " подписались на ", form_for_5: " подписались на ")
                    userAttributedString.appendAttributedString(NSAttributedString(string: actionString))
                    
                    // генерируем строку пользователей, на которых подписались
                    let subUsersString = self.generateSeparatedUserString(self.sub_user_names!, userIds: self.sub_user_ids!, userOthers: subAdditionalUsers!)
                    userAttributedString.appendAttributedString(subUsersString)
                    
                    // дозаписываем в строку количество остальных подпользователей
                    if subAdditionalUsers > 0 {
                        let pluralizedUsersString = pluralize(subAdditionalUsers!, form_for_1: " пользователя", form_for_2: " пользователей", form_for_5: " пользователей")
                        userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                    }
                }
                
                return userAttributedString
            }
        }
    }
}