//
//  SKProfileActivities.swift
//  ShakerNotifications
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

class SKInterestActivities: SKBaseActivities {
    
    private(set) var id: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["id"].stringValue
        self.photos = json["photos"].arrayObject as? [String]
        self.photo_ids = json["photo_ids"].arrayObject as? [String]
        self.count = json["count"].intValue
        self.is_mine = json["is_mine"].boolValue
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
                
                /*
                
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
                
                var attrString: NSMutableAttributedString = NSMutableAttributedString(string: object.valueForKey("example1")!.description)
                attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, attrString.length))
                
                var descString: NSMutableAttributedString = NSMutableAttributedString(string:  String(format: "    %@", object.valueForKey("example2")!.description))
                descString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, descString.length))
                
                attrString.appendAttributedString(descString);
                cell.textLabel?.attributedText = attrString
                
                
                *//*
                
                // генерируем кликабельную строку с адресом
                guard let addressString = self.address else { return userAttributedString }
                
                let url : NSString = "https://google.com/\(self.address)"
                let urlStr = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                let searchURL : NSURL = NSURL(string: urlStr)!
                
                userAttributedString.appendAttributedString(NSAttributedString(string: addressString,
                    attributes: [
                        //NSURL(string: "user_by_id://\(userId)")
                        NSLinkAttributeName : searchURL
                    ])
                )
                */
                return userAttributedString
            }
        }
    }
}