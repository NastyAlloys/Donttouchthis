//
//  SKAvatarContainerView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 16.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class SKAvatarContainerView: UIView {
    // MARK: - Properties -
    var iconImageView: UIImageView!
    let defaultImage = UIImage(named: "avatar.placeholder.png")
    var avatarButton: UIButton!
    weak var currentAvatarView: UIView?
    var imageTimestamp: NSTimeInterval = 0
    
    let numberOfSubContainers = 2
    
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = true
        
        self.configureButton()
        addSubview(self.avatarButton)
        
        constrain(self.avatarButton) { avatarButton in
            guard let superview = avatarButton.superview else { return }
            avatarButton.width == 44
            avatarButton.height == 44
            avatarButton.top == superview.top
            avatarButton.left == superview.left
            avatarButton.right == superview.right
            avatarButton.bottom == superview.bottom
//            superview.height == avatarButton.height
            superview.width == avatarButton.width
        }
        
        currentAvatarView = self.avatarButton
        //TODO Delete
//      avatarButton.bottom == superview.bottom ~ UILayoutPriority(900 + i)
        
        iconImageView = self.configureIconImageView()
        addSubview(iconImageView)
        bringSubviewToFront(iconImageView)
        
        constrain(avatarButton, iconImageView) { avatarButton, iconImageView in
            iconImageView.width == 15
            iconImageView.height == 15            
            iconImageView.bottom == avatarButton.bottom
            iconImageView.right == avatarButton.right
        }
    }
    
    // MARK: - UIView configuration -
    private func configureButton() {
        self.avatarButton = UIButton()
        
        self.avatarButton.setImage(defaultImage, forState: .Normal)
        self.avatarButton.setTitle("", forState: .Normal)
        self.avatarButton.backgroundColor = UIColor.lightGrayColor()
        self.avatarButton.layer.cornerRadius = 22
        self.avatarButton.layer.borderWidth = 1
        self.avatarButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatarButton.layer.masksToBounds = true
        self.avatarButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        self.avatarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        self.avatarButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        self.avatarButton.layer.shouldRasterize = true
        self.avatarButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func configureIconImageView() -> UIImageView {
        let iconImageView = UIImageView()
        
        iconImageView.backgroundColor = UIColor.clearColor()
        iconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        iconImageView.layer.shouldRasterize = true
        iconImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        iconImageView.layer.masksToBounds = false
        iconImageView.clipsToBounds = true
        iconImageView.hidden = false
        iconImageView.image = nil
        iconImageView.tag = 10
        
        return iconImageView
    }
    
    // MARK: - UIView update -
    func reset() {
        self.avatarButton.setImage(defaultImage, forState: .Normal)
    }
    
    func reload(data: SKBaseFeedback) {
        // задаем иконки
        switch data.feedbackType {
        case .Profile:
            iconImageView.image = UIImage(named: "notification.icon.profile")
        case .Like:
            iconImageView.image = UIImage(named: "notification.icon.like")
        case .Comment:
            iconImageView.image = UIImage(named: "notification.icon.comment")
        case .Repost:
            iconImageView.image = UIImage(named: "notification.icon.repost")
        case .Mention:
            iconImageView.image = UIImage(named: "notification.icon.mention")
        default:
            iconImageView.image = nil
        }
        
        // хадаем аватарки
        guard let user_avatar = data.user_avatar?.url else { return }
        
        self.imageTimestamp = NSDate().timeIntervalSince1970
        let imageTimestamp = self.imageTimestamp
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
            let imageUrl = NSURL(string: user_avatar)
            let imageData = NSData(contentsOfURL: imageUrl!)
            let image: UIImage = UIImage(data: imageData!)!
            
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                guard self?.imageTimestamp == imageTimestamp else { return }
                self?.avatarButton.setImage(image, forState: .Normal)
            }
        }
    }
    
}