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
import SwiftyJSON

class SKAvatarContainerView: UIView {
    // MARK: - Properties -
    var iconImageView: UIImageView!
    let defaultImage = UIImage(named: "avatar.placeholder.png")
    var avatarButton: UIButton!
    weak var currentAvatarView: UIView?
    
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
            avatarButton.width == 35
            avatarButton.height == 35
            avatarButton.top == superview.top
            avatarButton.left == superview.left
            avatarButton.right == superview.right
        }
        
        currentAvatarView = self.avatarButton
        /*
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
        }*/
        
        iconImageView = self.configureIconImageView()
        addSubview(iconImageView)
        bringSubviewToFront(iconImageView)
        
        constrain(avatarButton, iconImageView) { avatarButton, iconImageView in
            //            guard let superview = iconImageView.superview else { return }
            
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
        self.avatarButton.layer.cornerRadius = 16.5
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
        iconImageView.image = UIImage(named: "icon-notify-like")
        iconImageView.tag = 10
        
        return iconImageView
    }
    
    private func configureImageView() -> UIImageView {
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
    
    // MARK: - UIView update -
    func reset() {
        let subviews = self.subviews
        
        for view in subviews {
            if let view = view as? UIImageView where view !== iconImageView {
                view.image = defaultImage
                view.hidden = true
            } else if let button = view as? UIButton {
                button.setImage(defaultImage, forState: .Normal)
            }
        }
    }
    
    func reload(cellData: JSON) {
//        guard let images = cellData["images"] else { return }
        
        guard let user_avatar = cellData["user_avatar"].string else { return }
        
        let imageUrl = NSURL(string: user_avatar)
        let imageData = NSData(contentsOfURL: imageUrl!)
        let image: UIImage = UIImage(data: imageData!)!
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.avatarButton.setImage(image, forState: .Normal)
        })

        /*
        let subviews = self.subviews

        var imageIndex = 0
        
        for view in subviews.reverse() {
            guard imageIndex < images.count else { break }
            let image = images[imageIndex]
            
            if let view = view as? UIButton {
                view.imageView?.imageFromUrl(user_avatar)
                view.setImage(UIImage(named: user_avatar), forState: .Normal)
            }
            else if let view = view as? UIImageView where view !== iconImageView {
                view.hidden = false
                view.image = UIImage(named: image)
            } else {
                continue
            }
        
            imageIndex++
        }*/
    }
    
}