//
//  BodyDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import TTTAttributedLabel
import Cartography
import SwiftyJSON
import Stencil

class ProfileDescriptionView: DescriptionView {
    private(set) var descriptionLabel: TTTAttributedLabel!
    
    
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
        
        self.descriptionLabel.text = ""
    }
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
        
        self.descriptionLabel.setText(data.activityDescription.value)
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

        self.descriptionLabel.text = profileString
    }
    
    private func commonInit() {
        self.setUpDescriptionLabel()
        self.reset()
        self.addSubview(self.descriptionLabel)
        
        constrain(descriptionLabel) { descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.bottom == superview.bottom
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
        }
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = TTTAttributedLabel(frame: .zero)
        self.descriptionLabel.delegate = self
        self.descriptionLabel.backgroundColor = UIColor.whiteColor()
        self.descriptionLabel.clipsToBounds = true
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
}

extension ProfileDescriptionView: TTTAttributedLabelDelegate {
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        guard let url = url else { return }
        UIApplication.sharedApplication().openURL(url)
    }
}