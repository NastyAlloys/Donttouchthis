//
//  InterestDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Cartography

class ShakeDescriptionView: DescriptionView {
    private(set) var descriptionButton: UIButton!
    private(set) var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func reset() {
        super.reset()
        
        self.descriptionButton.setImage(nil, forState: .Normal)
        self.descriptionLabel.text = ""
    }
    
    override func reload(json: JSON) {
        super.reload(json)
        
        var profileString = ""
        
        // Записываем в строку подписывающихся пользователей
        let userNames = json["user_names"].arrayObject as! [String]
        let userNamesCount = userNames.count
        
        switch userNamesCount {
        case 2 :
            profileString += "\(userNames[0]) и \(userNames[1])"
        case 3 :
            profileString += "\(userNames[0]), \(userNames[1]) и \(userNames[2])"
        case let i where i > 2:
            let pluralizedUsersString = pluralize(i - 3, form_for_1: "пользователю", form_for_2: "пользователям", form_for_5: "пользователям")
            profileString += "\(userNames[0]), \(userNames[1]) и еще \(i - 3) \(pluralizedUsersString)"
        default :
            profileString += "\(userNames[0])"
        }
        
        // дозаписываем в строку глагол
        let pluralizedVerbString = pluralize(userNamesCount, form_for_1: "подписался(ась)", form_for_2: "подписались", form_for_5: "подписались")
        profileString += " " + pluralizedVerbString + " на "
        
        // дозаписываем в строку пользователей, на которых подписались
        let subUserNames = json["body"]["sub_user_names"].arrayObject as! [String]
        let subUserNamesCount = subUserNames.count
        
        switch subUserNamesCount {
        case 2 :
            profileString += "\(subUserNames[0]) и \(subUserNames[1])"
        case 3 :
            profileString += "\(subUserNames[0]), \(subUserNames[1]) и \(subUserNames[2])"
        case let i where i > 2:
            let pluralizedUsersString = pluralize(i - 3, form_for_1: "пользователя", form_for_2: "пользователей", form_for_5: "пользователей")
            profileString += "\(subUserNames[0]), \(subUserNames[1]) и еще \(i - 3) \(pluralizedUsersString)"
        default :
            profileString += "\(subUserNames[0])"
        }
        
        self.descriptionLabel.textColor = UIColor.whiteColor()
        self.descriptionLabel.font = UIFont(name: self.descriptionLabel.font.fontName, size: 15)
        self.descriptionLabel.text = profileString
    }
    
    private func commonInit() {
        self.setUpDescriptionButton()
        self.setUpDescriptionLabel()
        self.reset()
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionButton)
        
        constrain(descriptionButton, descriptionLabel) { descriptionButton, descriptionLabel in
            guard let superview = descriptionButton.superview else { return }
            
            descriptionButton.width == 35
            descriptionButton.height == 35
            descriptionButton.right == superview.right - 15
            descriptionButton.top == superview.top + 10
            
            descriptionLabel.top == superview.top + 10
            descriptionLabel.bottom == superview.bottom - 10
            descriptionLabel.left == superview.left + 10
            descriptionLabel.right == descriptionButton.left - 10
            descriptionLabel.height == 100
        }
    }
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.setTitle("SHIT", forState: .Normal)
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.backgroundColor = UIColor.blueColor()
        self.descriptionLabel.clipsToBounds = false
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
}
