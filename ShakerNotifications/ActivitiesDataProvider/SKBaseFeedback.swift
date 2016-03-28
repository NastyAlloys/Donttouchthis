//
//  SKBaseFeedback.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 02.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK: - FEEDBACK MODEL -
enum SKFeedbackModel: String {
    case None, Profile
    case LikeShake, LikePublication, LikeQuote, LikeInterest
    case CommentPublication, CommentQuote, CommentShake
    case MentionPublication, MentionComment
    case RepostPublication, RepostQuote
    
    init(type: JSON, subtype: JSON) {
        switch (type.stringValue, subtype.stringValue) {
            
        // ЛАЙК ШЕЙКА
        case ("like", "shake"):
            self = .LikeShake
            
        // ЛАЙК ПУБЛИКАЦИИ
        case ("like", "publication"):
            self = .LikePublication
            
        // ЛАЙК ЦИТАТЫ
        case ("like", "quote"):
            self = .LikeQuote
            
        // ЛАЙК НОВОСТИ
        case ("like", "interest"):
            self = .LikeInterest
            
        // ПОДПИСКА
        case ("profile", ""):
            self = .Profile
            
        // РЕПОСТ ПУБЛИКАЦИИ
        case ("repost", "publication"):
            self = .RepostPublication
            
        // РЕПОСТ ЦИТАТЫ
        case ("repost", "quote"):
            self = .RepostQuote
            
        // УПОМИНАНИЕ ПУБЛИКАЦИИ
        case ("mention", "publication"):
            self = .MentionPublication
            
        // УПОМИНАНИЕ КОММЕНТА
        case ("mention", "comment"):
            self = .MentionComment
            
        // КОММЕНТ К ПУБЛИКАЦИИ
        case ("comment", "publication"):
            self = .CommentPublication
            
        // КОММЕНТ К ШЕЙКУ
        case ("comment", "shake"):
            self = .CommentShake
            
        // КОММЕНТ К ЦИТАТЕ
        case ("comment", "quote"):
            self = .CommentQuote
            
        default:
            self = .None
        }
    }
}

enum SKFeedbackType: String {
    case None, Profile, Like, Comment, Mention, Repost
    
    init(json: JSON) {
        switch json.stringValue {
        case "profile":
            self = .Profile
        case "like":
            self = .Like
        case "comment":
            self = .Comment
        case "mention":
            self = .Mention
        case "repost":
            self = .Repost
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

class SKBaseFeedback {
    // Описание для DescriptionView
    var feedbackDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                return NSAttributedString(string: "")
            }
        }
    }
    
    // MARK: - Initialization -
    private(set) var feedbackId: String = ""
    private(set) var feedbackModelType: SKFeedbackModel = .None
    private(set) var feedbackType: SKFeedbackType = .None
    private(set) var feedbackSubtype: String = ""
    private(set) var timestamp: NSTimeInterval = 0
    private(set) var with_photo: Int = 0
    private(set) var user_ids: [String] = []
    private(set) var user_names: [String] = []
    private(set) var user_avatar: UserAvatar?
    private(set) var user_others: Int = 0
    private(set) var owner_id: String = ""
    private(set) var owner_name: String = ""
    
    init() {
    
    }
    
    required init(json: JSON) {
        self.feedbackId = json["id"].stringValue
        self.feedbackModelType = SKFeedbackModel(type: json["type"], subtype: json["subtype"])
        self.feedbackType = SKFeedbackType(json: json["type"])
        self.feedbackSubtype = json["subtype"].stringValue
        self.timestamp = json["timestamp"].doubleValue
        self.with_photo = json["with_photo"].intValue
        self.user_ids = json["user_ids"].arrayObject as! [String]
        self.user_names = json["user_names"].arrayObject as! [String]
        self.user_avatar = UserAvatar(json: json["user_avatar"])
        self.user_others = json["user_others"].intValue
        self.owner_id = json["owner_id"].stringValue
        self.owner_name = json["owner_name"].stringValue
    }
    
    /*
        Конвертирует json-данные в определенный класс, основываясь SKFeedbackModelType
    */
    final class func convert(json json: JSON) -> SKBaseFeedback? {
        let feedbackModelType = SKFeedbackModel(type: json["type"], subtype: json["subtype"])
        
        switch feedbackModelType {
        // Профиль
        case .Profile:
            return SKProfileFeedback(json: json)
        // Лайк
        case .LikeShake:
            return SKLikeShakeFeedback(json: json)
        case .LikeInterest:
            return SKLikeInterestFeedback(json: json)
        case .LikeQuote:
            return SKLikeQuoteFeedback(json: json)
        case .LikePublication:
            return SKLikePublicationFeedback(json: json)
        // Коммент
        case .CommentShake:
            return SKCommentShakeFeedback(json: json)
        case .CommentQuote:
            return SKCommentQuoteFeedback(json: json)
        case .CommentPublication:
            return SKCommentPublicationFeedback(json: json)
        // Репост
        case .RepostQuote:
            return SKRepostQuoteFeedback(json: json)
        case .RepostPublication:
            return SKRepostPublicationFeedback(json: json)
        // Упоминание
        case .MentionComment:
            return SKMentionCommentFeedback(json: json)
        case .MentionPublication:
            return SKMentionPublicationFeedback(json: json)
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
                let userUrl = NSURL(string: "shaker://user/\(userId)")!
                userAttributedString.appendAttributedString(NSAttributedString(string: coma))
                userAttributedString.appendAttributedString(NSAttributedString(string: value,
                    attributes: [
                        //NSURL(string: "user_by_id://\(userId)")
                        NSLinkAttributeName : userUrl,
                        NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleNone.rawValue
                    ]))
            }
            
            // добавляем строку для количества остальных пользователей
            let additionalUsers = userOthers
            if additionalUsers > 0 {
                let resultString = " и ещё \(additionalUsers)"
                let coloredString = self.setAttributedStringColor(resultString, color: UIColor.darkGrayColor())
                userAttributedString.appendAttributedString(coloredString)
            }
        }
        
        let attributedText = NSMutableAttributedString()
        attributedText.appendAttributedString(userAttributedString)
        
        return attributedText
        
    }
    
    /*
        Меняет цвет NSAttributedString на цвет, переданный в параметре
    */
    func setAttributedStringColor(string: String, color:UIColor) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [
            NSForegroundColorAttributeName:color
            ])
    }
}
