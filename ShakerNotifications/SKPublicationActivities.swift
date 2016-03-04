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
        
        self.id = json["id"].stringValue
        self.photos = json["photos"].arrayObject as? [String]
        self.photo_ids = json["photo_ids"].arrayObject as? [String]
        self.count = json["count"].intValue
        self.is_mine = json["is_mine"].boolValue
    }
    
    override var activityDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                return NSAttributedString(string: "publication")
            }
        }
    }
}