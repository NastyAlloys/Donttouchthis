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


class SKAvatarContainerView {
    
}

struct LayoutConstants {
    static let buttonHeight: CGFloat = 35
}



class NotificationBodyViewCell: UITableViewCell {
    
    var avatarContainerView: UIView!// = UIView()
    var descriptionContainerView = UIView()
    
    var avatarContainerConstraint: NSLayoutConstraint!
    var descriptionContainerConstraint: NSLayoutConstraint!
    
    weak var currentAvatarView: UIView?
    
    var defaultImage: UIImage! = UIImage(named: "avatar.placeholder.png")
    
    var avatarButton = UIButton() as UIButton
    var avatarImage: UIImage!
    var avatarImageView: UIImageView!
    
    var iconImageView: UIImageView!
    
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
        
        let whiteColor: UIColor = UIColor.whiteColor()
        
        self.avatarContainerView = UIView()
        // Добавляем два главных контейнера:
        // 1 - для аватара/-ов
        // 2 - для описания нотификации
        avatarContainerView.clipsToBounds = false
        contentView.addSubview(self.avatarContainerView)
        contentView.addSubview(self.descriptionContainerView)
        
        // настройка главного Subview класса UIButton в avatarContainerView
        avatarButton.backgroundColor = UIColor.lightGrayColor()
        avatarButton.layer.cornerRadius = 16.5
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = whiteColor.CGColor
        avatarButton.layer.masksToBounds = true
        avatarButton.setImage(defaultImage, forState: .Normal)
        avatarButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        avatarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        avatarButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        avatarButton.setTitle("", forState: .Normal)
        avatarButton.layer.shouldRasterize = true
        avatarButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        
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
        
        constrain(avatarButton) { avatarButton in
            guard let superview = avatarButton.superview else { return }
            avatarButton.width == 35
            avatarButton.height == 35
            avatarButton.top == superview.top
            avatarButton.left == superview.left
            avatarButton.right == superview.right
        }
        
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
            
            nameLabel.top == superview.top + 10
            nameLabel.left == superview.left + 10
            nameLabel.right == descriptionButton.left - 10
            
            descriptionLabel.top == nameLabel.bottom + 1
            descriptionLabel.bottom == superview.bottom - 10 ~ 752
            descriptionLabel.left == superview.left + 10
            descriptionLabel.right == descriptionButton.left - 10

            

//            name.top == superview.top + 10
//            name.left == superview.right + 10
//            
//            description.left == superview.right + 10
//            description.top == name.bottom + 1
//            
//            superview.right == button.right + 15
//            
//            button.left == name.right + 10
//            button.left == description.right + 10
//            button.top == superview.top + 10
            
        }
        
        constrain(descriptionButton) { descriptionButton in
//            guard let superview = descriptionButton.superview else { return }
//            descriptionButton.width == 35
//            descriptionButton.height == 35
//            superview.right == descriptionButton.right + 15
//            descriptionButton.top == superview.top + 10
        }
        
    }
    
    func reset() {
        self.selectionStyle = .None
        
        avatarButton.setImage(defaultImage, forState: .Normal)
        
        let subviews = avatarContainerView.subviews
        
        for view in subviews {
            if let view = view as? UIImageView {
                view.image = defaultImage
                view.hidden = true
            }
        }
    }
    
    func reload(cellData: [String: [String]]) {
        guard let images = cellData["images"] else { return }
        
        let subviews = avatarContainerView.subviews
        var imageIndex = 0
        
        for view in subviews.reverse() {
            guard imageIndex < images.count else { break }
            let image = images[imageIndex]
            
            if let view = view as? UIButton {
                view.setImage(UIImage(named: image), forState: .Normal)
            } else if let view = view as? UIImageView {
                view.hidden = false
                view.image = UIImage(named: image)
            }
            
            imageIndex++
        }
    }
}
