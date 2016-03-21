//
//  SKPublicationActivities.swift
//  ShakerNotifications
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

class SKPublicationActivities: SKBaseActivities {
    
    private(set) var id: String? = ""
    private(set) var photos: [String]? = []
    private(set) var photo_ids: [String]? = []
    private(set) var count: Int? = 0
    private(set) var is_mine: Bool? = false
    
    required init(json: JSON) {
        super.init(json: json)
        
        self.id = json["body"]["id"].stringValue
        self.photos = json["body"]["photos"].arrayObject as? [String]
        self.photo_ids = json["body"]["photo_ids"].arrayObject as? [String]
        self.count = json["body"]["count"].intValue
        self.is_mine = json["body"]["is_mine"].boolValue
    }
    
    override var activityDescription: Lazy<NSAttributedString> {
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
                
                userAttributedString.appendAttributedString(NSAttributedString(string: " нравится \(self.count!) публикаций"))
                
                return userAttributedString
            }
        }
    }
}