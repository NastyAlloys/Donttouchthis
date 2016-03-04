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
        
        self.id = json["id"].stringValue
        self.count = json["count"].intValue
        self.is_mine = json["is_mine"].boolValue
        self.address = json["address"].stringValue
    }
   
    override var activityDescription: Lazy<NSAttributedString> {
        get {
            return Lazy {
                return NSAttributedString(string : "shake")
            }
        }
    }
}