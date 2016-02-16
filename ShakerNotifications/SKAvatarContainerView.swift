//
//  SKAvatarContainerView.swift
//  ShakerNotifications
//
//  Created by Andrew on 16.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class SKAvatarContainerView: UIView {
    // MARK: - Properties -
    
    var avatarImageView = UIImageView()
    var iconImageView = UIImageView()
    let defaultImage = UIImage(named: "avatar.placeholder.png")
    weak var currentAvatarView: UIView?
    
    let numberOfSubContainers = 2
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let avatarButton = self.configureButton()
        addSubview(avatarButton)
        
        constrain(avatarButton) { avatarButton in
            guard let superview = avatarButton.superview else { return }
            avatarButton.width == 35
            avatarButton.height == 35
            avatarButton.top == superview.top
            avatarButton.left == superview.left
            avatarButton.right == superview.right
        }
        
        currentAvatarView = avatarButton
        
        for var i = 0; i < numberOfSubContainers; i++ {
            
            let imageView = self.configureImageView()
            
            addSubview(imageView)
            sendSubviewToBack(imageView)
            
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
        
        iconImageView = self.configureIconImageView()
        addSubview(iconImageView)
        bringSubviewToFront(iconImageView)

        constrain(avatarButton, iconImageView) { avatarButton, iconImageView in
            guard let superview = iconImageView.superview else { return }
            
            iconImageView.width == 15
            iconImageView.height == 15
            
            iconImageView.bottom == avatarButton.bottom
            iconImageView.right == avatarButton.right
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    func configureButton() -> UIButton {
        let button = UIButton()
        button.setImage(defaultImage, forState: .Normal)
        button.setTitle("", forState: .Normal)
        button.backgroundColor = UIColor.lightGrayColor()
        button.layer.cornerRadius = 16.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.masksToBounds = true
        button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return button
    }
    
    func configureIconImageView() -> UIImageView {
        let iconImageView = UIImageView()
        
        iconImageView.backgroundColor = UIColor.whiteColor()
        iconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        iconImageView.layer.shouldRasterize = true
        iconImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        iconImageView.layer.masksToBounds = false
        iconImageView.clipsToBounds = true
        iconImageView.hidden = false
        iconImageView.image = UIImage(named: "icon-notify-like")
        iconImageView.tag = 10
        
        return iconImageView
    }
    
    func configureImageView() -> UIImageView {
        let imageView = UIImageView()
            
//        imageView.image = defaultImage
        imageView.backgroundColor = UIColor.lightGrayColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        imageView.layer.cornerRadius = 16.5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        return imageView
    }
    
}