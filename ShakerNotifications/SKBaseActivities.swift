//
//  SKBaseActivities.swift
//  ShakerNotifications
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

@objc enum SKActivitiesModelType: Int {
    case None, Like, Profile
    
    init(json: JSON) {
        switch json.stringValue {
        case "like":
            self = .Like
        case "profile":
            self = .Profile
        default:
            self = .None
        }
    }
}

@objc enum SKActivitiesModelSubtype: Int {
    case None, Profile, Like, LikeShake, LikePublication, LikeQuote, LikeInterest
    
    init(json: JSON) {
        switch json.stringValue {
        case "shake":
            self = .LikeShake
        case "publication":
            self = .LikePublication
        case "quote":
            self = .LikeQuote
        case "interest":
            self = .LikeInterest
        default:
            self = .None
        }
    }
}

// класс для хэша user_avatar в json
struct UserAvatar {
    var timestamp: NSTimeInterval = 0
    var url: String?
    
    init(json: JSON) {
        self.timestamp = json["timestamp"].doubleValue
        self.url = json["url"].string
    }
}

class SKBaseActivities {
    
//    lazy private(set) var feedHeight: Lazy<CGFloat> = Lazy {
//        return NotificationCell.getHeight(self.type(), data: self)
//    }
//    
    
    /*
        Описание для DescriptionView
    */
    var activityDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                return NSAttributedString(string: "")
            }
        }
    }
    
    // MARK: - Initialization -
    private(set) var activityId: String = ""
    private(set) var activityType: SKActivitiesModelType = .None
    private(set) var activitySubtype: SKActivitiesModelSubtype = .None
    private(set) var timestamp: NSTimeInterval = 0
    private(set) var with_photo: Bool = false
    private(set) var user_ids: [String] = []
    private(set) var user_names: [String] = []
    private(set) var user_avatar: UserAvatar?
    private(set) var user_others: Int = 0
    private(set) var owner_id: String = ""
    private(set) var owner_name: String = ""
    
    init() {
    
    }
    
    required init(json: JSON) {
        self.activityId = json["id"].stringValue
        self.activityType = SKActivitiesModelType(json: json["type"])
        self.activitySubtype = SKActivitiesModelSubtype(json: json["subtype"])
        self.timestamp = json["timestamp"].doubleValue
        self.with_photo = json["with_photo"].boolValue
        self.user_ids = json["user_ids"].arrayObject as! [String]
        self.user_names = json["user_names"].arrayObject as! [String]
        self.user_avatar = UserAvatar(json: json["user_avatar"])
        self.user_others = json["user_others"].intValue
        self.owner_id = json["owner_id"].stringValue
        self.owner_name = json["owner_name"].stringValue
    }
    
    /*
        Конвертирует json-данные в определенный класс, основываясь на type и subtype
    */
    final class func convert(json json: JSON) -> SKBaseActivities? {
        let type = SKActivitiesModelType(json: json["type"])
        let subtype = SKActivitiesModelSubtype(json: json["subtype"])
        
        switch type {
        case .Profile:
            return SKProfileActivities(json: json)
        case .Like:
            switch subtype {
            case .LikeShake:
                return SKShakeActivities(json: json)
            case .LikeInterest:
                return SKInterestActivities(json: json)
            case .LikeQuote:
                return SKQuoteActivities(json: json)
            case .LikePublication:
                return SKPublicationActivities(json: json)
            default:
                break
            }
        default:
            break
        }

        return self.init(json: json)
    }
    
    /*
        Генерирует строку пользователей с разделителями основываясь на следующих параметрах:
            - userNames: никнэймы пользователей
            - userIds: их идентификаторы
            - userOthers: количество оставшихся пользователей, не вошедних в массив userNames
    */
    func generateSeparatedUserString(userNames: [String], userIds: [String], userOthers: Int) -> NSMutableAttributedString {
        
        let userAttributedString = NSMutableAttributedString()
        
        do {
            let userNamesCount = userNames.count
            
            for (index, value) in userNames.enumerate() {
                let coma: String
                
                // в зависимости от количества пользователей добавляем сепаратор
                switch index {
                case 0:
                    coma = ""
                case let i where i == userNamesCount - 1:
                    coma = " и "
                default:
                    coma = ", "
                }
                
                // TODO check count
                let userId = userIds[index]
                
                // добавляем сепаратор и пользователей с линкой на профиль
                userAttributedString.appendAttributedString(NSAttributedString(string: coma))
                userAttributedString.appendAttributedString(NSAttributedString(string: value,
                    attributes: [
                        //NSURL(string: "user_by_id://\(userId)")
                        NSLinkAttributeName : NSURL(string: "https://google.com/\(userId)")!
                    ]))
            }
            
            // добавляем строку для количества остальных пользователей
            let additionalUsers = userOthers
            if additionalUsers > 0 {
                let resultString = " и ещё \(additionalUsers)"
                userAttributedString.appendAttributedString(NSAttributedString(string: resultString))
            }
        }
        
        let attributedText = NSMutableAttributedString()
        attributedText.appendAttributedString(userAttributedString)
        
        return attributedText
        
    }
}
