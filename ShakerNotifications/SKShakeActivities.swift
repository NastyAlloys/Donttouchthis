//
//  SKProfileActivities.swift
//  ShakerNotifications
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

class SKShakeActivities: SKBaseActivities {
    
    private(set) var id: String? = ""
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    private(set) var address: String? = ""
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
        self.address = json["body"]["address"].stringValue
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
                    let pluralizedUsersString = pluralize(additionalUsers, form_for_1: " пользователь", form_for_2: " пользователя", form_for_5: " пользователей")
                    userAttributedString.appendAttributedString(NSAttributedString(string: pluralizedUsersString))
                }
                
                // генерируем связующий глагол
                let text = " нравится шейк в "
                userAttributedString.appendAttributedString(NSAttributedString(string: text))
                
                // генерируем кликабельную строку с адресом
                guard let addressString = self.address else { return userAttributedString }
                
                let url : NSString = "https://google.com/\(self.address)"
                let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                let searchURL : NSURL = NSURL(string: urlStr)!
                
                userAttributedString.appendAttributedString(NSAttributedString(string: addressString,
                    attributes: [
                        //NSURL(string: "user_by_id://\(userId)")
                        NSLinkAttributeName : searchURL,
                        NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                    ])
                )
                
                return userAttributedString
            }
        }
    }
}