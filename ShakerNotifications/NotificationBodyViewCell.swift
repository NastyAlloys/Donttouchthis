//
//  NotficationBodyViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Foundation
import Cartography

class NotificationBodyViewCell: UITableViewCell {
    // MARK: - Properties -
    var avatarContainerView: SKAvatarContainerView!
    var descriptionContainerView: SKDescriptionContainerView!
    
   // MARK: - Initialization - 
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpViews()
        self.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpViews()
        self.reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    /*
        Настройка контейнеров для аватаров и для описания и
        constrain для них
    */
    func setUpViews() {
        
        self.clipsToBounds = true
        
        self.avatarContainerView = SKAvatarContainerView()
        self.descriptionContainerView = SKDescriptionContainerView()
        
        contentView.addSubview(self.avatarContainerView)
        contentView.addSubview(self.descriptionContainerView)
        
        constrain(avatarContainerView, descriptionContainerView) { avatarContainerView, descriptionContainerView in
            guard let superview = avatarContainerView.superview else { return }
            avatarContainerView.left == superview.left + 10
            avatarContainerView.top == superview.top + 10
            
            descriptionContainerView.top == avatarContainerView.top
            descriptionContainerView.left == avatarContainerView.right + 8
            descriptionContainerView.bottom == superview.bottom
            descriptionContainerView.right == superview.right - 10 ~ 751
        }
        
    }
    
    /*
        Сброс вьюхи для переиспользования ячейки
    */
    func reset() {
        self.selectionStyle = .None
        self.avatarContainerView.reset()
    }
    
    /*
        Апдейт ячейки
    */
    func reload(cellData: [String: [String]]) {
        guard let images = cellData["images"] else { return }
        
//        self.avatarContainerView.reload(images)
    }
}
