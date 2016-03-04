//
//  ActivitiesViewModel.swift
//  ShakerNotifications
//
//  Created by Andrew on 01.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//
/*
import UIKit
import SwiftyJSON
//import Gloss
import ObjectMapper


class SingleNotificationBody: Mappable {
    
    var test: SingleLikeNotificationBody!
    
    var feed_id: String?
    var type: String?
    var subtype: String?
    var timestamp: Int?
    var with_photo: Bool?
//    let body: 
    var user_ids: NSArray?
    var user_names: NSArray?
    var user_avatar: UserAvatar?
    var user_others: Int?
    
    required init?(_ map: Map){
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        feed_id <- map["id"]
        type <- map["type"]
        subtype <- map["subtype"]
        timestamp <- map["timestamp"]
        with_photo <- map["with_photo"]
        user_ids <- map["user_ids"]
        user_names <- map["user_names"]
        user_avatar <- map["user_avatar"]
        user_others <- map["user_others"]
    }
    
    // MARK: - Deserialization
    
//    init?(json: JSON) {
//        self.feed_id = "id" <~~ json
//        self.type = "type" <~~ json
//        self.subtype = "subtype" <~~ json
//        self.timestamp = "timestamp" <~~ json
//        self.with_photo = "with_photo" <~~ json
//        self.user_ids = "user_ids" <~~ json
//        self.user_names = "user_names" <~~ json
//        self.user_avatar = "user_avatar" <~~ json
//        self.user_others = "user_others" <~~ json
////        self.body = "body" <~~ json
//    }
    
    func createWithJSON(json: JSON) {
        
        if let notificationDict = json.dictionary {
            if let type = notificationDict["type"]!.string {
                switch type {
                case "like" where subtype == "shake":
                    Mapper<SingleProfileNotificationBody>()
                    
                case "like" where subtype == "publication":
                    self.test.dynamicType = SinglePublicationNotificationBody()
                    
                case "like" where subtype == "quote":
                    return SingleQuoteNotificationBody()
                    
                case "like" where subtype == "interest":
                    return SingleInterestNotificationBody()
                    
                case "profile":
                    return SingleProfileNotificationBody()
                }
            }
        }
        
        
    }
}

class SingleProfileNotificationBody: SingleNotificationBody {
    var sub: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
    
}

class SingleLikeNotificationBody: SingleNotificationBody {
    var sub: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
    
}

class SinglePublicationNotificationBody: SingleNotificationBody {
    var sub: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
    
}

class SingleQuoteNotificationBody: SingleNotificationBody {
    var sub: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
    
}

class SingleInterestNotificationBody: SingleNotificationBody {
    var sub: String?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        sub <- map["sub"]
    }
    
}

//struct
*/


