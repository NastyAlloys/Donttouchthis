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

struct LayoutConstants {
    static let buttonHeight: CGFloat = 35
}

class NotificationBodyViewCell: UITableViewCell {
    
    var avatarContainerView: SKAvatarContainerView!// = UIView()
    var descriptionContainerView = UIView()
    
    var avatarContainerConstraint: NSLayoutConstraint!
    var descriptionContainerConstraint: NSLayoutConstraint!
    
    weak var currentAvatarView: UIView?
    
    var defaultImage: UIImage! = UIImage(named: "avatar.placeholder.png")
    
    var avatarButton = UIButton() as UIButton
    var avatarImage: UIImage!
    var avatarImageView: UIImageView!
    
    //    var iconImageView = UIImageView()
    
    var nameLabel = UILabel() as UILabel!
    var descriptionLabel = UILabel() as UILabel!
    var descriptionButton = UIButton() as UIButton!
    
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
    
    // MARK: define avatar UIViews & ImageViews
    func setUpViews() {
        
        self.clipsToBounds = true
        
        self.avatarContainerView = SKAvatarContainerView()
        // Добавляем два главных контейнера:
        // 1 - для аватара/-ов
        // 2 - для описания нотификации
        avatarContainerView.clipsToBounds = false
        contentView.addSubview(self.avatarContainerView)
        contentView.addSubview(self.descriptionContainerView)
        /*
        // настройка главного Subview класса UIButton в avatarContainerView
        avatarButton.backgroundColor = UIColor.lightGrayColor()
        avatarButton.layer.cornerRadius = 16.5
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = whiteColor.CGColor
        //        avatarButton.layer.masksToBounds = false
        avatarButton.setImage(defaultImage, forState: .Normal)
        avatarButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        avatarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        avatarButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        avatarButton.setTitle("", forState: .Normal)
        avatarButton.layer.shouldRasterize = true
        avatarButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        iconImageView.backgroundColor = UIColor.clearColor()
        iconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        iconImageView.layer.shouldRasterize = true
        iconImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        iconImageView.layer.masksToBounds = true
        iconImageView.hidden = false
        iconImageView.image = UIImage(named: "icon-notify-like")
        
        avatarButton.addSubview(self.iconImageView)
        avatarButton.bringSubviewToFront(self.iconImageView)
        
        avatarContainerView.addSubview(avatarButton)
        
        currentAvatarView = avatarButton
        
        let numberOfSubContainers = 2
        
        for var i = 0; i < numberOfSubContainers; i++ {
        
        //            let frame = currentAvatarView.frame
        
        let imageView = UIImageView()
        
        imageView.image = defaultImage
        imageView.backgroundColor = UIColor.lightGrayColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        imageView.layer.cornerRadius = 16.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = whiteColor.CGColor
        
        avatarContainerView.addSubview(imageView)
        avatarContainerView.sendSubviewToBack(imageView)
        
        do {
        guard let currentAvatarView = currentAvatarView  else { continue }
        
        constrain(imageView, currentAvatarView) { avatarButton, currentAvatarView in
        guard let superview = avatarButton.superview else { return }
        avatarButton.width == currentAvatarView.width
        avatarButton.height == currentAvatarView.height
        avatarButton.top == currentAvatarView.top + 3
        avatarButton.left == currentAvatarView.left
        avatarButton.bottom == superview.bottom ~ UILayoutPriority(900 + i)
        }
        }
        
        currentAvatarView = imageView
        }
        
        avatarImage = UIImage(named: "avatar.placeholder.png")
        avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.frame = CGRectMake(0, 0, 35, 35)
        
        constrain(avatarButton, iconImageView) { avatarButton, iconImageView in
        guard let superview = avatarButton.superview else { return }
        avatarButton.width == 35
        avatarButton.height == 35
        avatarButton.top == superview.top
        avatarButton.left == superview.left
        avatarButton.right == superview.right
        
        iconImageView.width == 15
        iconImageView.height == 15
        
        avatarButton.bottom == iconImageView.bottom
        iconImageView.right == avatarButton.right
        }
        */
        self.descriptionContainerView.clipsToBounds = true
        
        constrain(avatarContainerView, descriptionContainerView) { avatarContainerView, descriptionContainerView in
            guard let superview = avatarContainerView.superview else { return }
            avatarContainerView.left == superview.left + 10
            avatarContainerView.top == superview.top + 10
            
            descriptionContainerView.top == avatarContainerView.top
            descriptionContainerView.left == avatarContainerView.right + 8
            descriptionContainerView.bottom == superview.bottom
            descriptionContainerView.right == superview.right - 10 ~ 751
        }
        
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.setTitle("SHIT", forState: .Normal)
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.nameLabel.backgroundColor = UIColor.grayColor()
        self.nameLabel.clipsToBounds = false
        self.nameLabel.textColor = UIColor.blackColor()
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.descriptionLabel.backgroundColor = UIColor.blueColor()
        self.descriptionLabel.clipsToBounds = false
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.descriptionContainerView.addSubview(self.descriptionButton)
        self.descriptionContainerView.addSubview(self.nameLabel)
        self.descriptionContainerView.addSubview(self.descriptionLabel)
        
        constrain(descriptionButton, descriptionLabel, nameLabel) { descriptionButton, descriptionLabel, nameLabel in
            guard let superview = nameLabel.superview else { return }
            
            descriptionButton.width == 35
            descriptionButton.height == 35
            descriptionButton.right == superview.right - 15
            descriptionButton.top == superview.top + 10
            
            nameLabel.left == superview.left + 10
            nameLabel.top == superview.top + 10
            nameLabel.right == descriptionButton.left - 10
            
            descriptionLabel.top == nameLabel.bottom + 1
            descriptionLabel.bottom == superview.bottom - 10 ~ 752
            descriptionLabel.left == superview.left + 10
            descriptionLabel.right == descriptionButton.left - 10
            
            nameLabel.height == descriptionLabel.height
        }
        
    }
    
    func reset() {
        self.selectionStyle = .None
        self.avatarContainerView.reset()
    }
    
    func reload(cellData: [String: [String]]) {
        guard let images = cellData["images"] else { return }
        
        self.avatarContainerView.reload(images)
    }
}
