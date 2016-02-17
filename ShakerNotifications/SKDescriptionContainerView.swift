//
//  SKAvatarDescriptionContainerView.swift
//  ShakerNotifications
//
//  Created by Andrew on 16.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class SKDescriptionContainerView: UIView {
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
        
        let descriptionButton = configureDescriptionButton()
        addSubview(descriptionButton)
        
        let nameLabel = configureNameLabel()
        addSubview(nameLabel)
        
        let descriptionLabel = configureDescriptionLabel()
        addSubview(descriptionLabel)
        
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
            descriptionLabel.bottom == superview.bottom - 10
            descriptionLabel.left == superview.left + 10
            descriptionLabel.right == descriptionButton.left - 10
            
            nameLabel.height == descriptionLabel.height
        }
    }
    
    // MARK: - UIView configuration -
    private func configureDescriptionButton() -> UIButton {
        let descriptionButton = UIButton()
        
        descriptionButton.backgroundColor = UIColor.blackColor()
        descriptionButton.setTitle("SHIT", forState: .Normal)
        descriptionButton.layer.shouldRasterize = true
        descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return descriptionButton
    }
    
    private func configureNameLabel() -> UILabel {
        let nameLabel = UILabel()
        
        nameLabel.backgroundColor = UIColor.grayColor()
        nameLabel.clipsToBounds = false
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return nameLabel
    }
    
    private func configureDescriptionLabel() -> UILabel {
        let descriptionLabel = UILabel()
        
        descriptionLabel.backgroundColor = UIColor.blueColor()
        descriptionLabel.clipsToBounds = false
        descriptionLabel.textColor = UIColor.lightGrayColor()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return descriptionLabel
    }
    
    // MARK: - UIView update -
    func reset() {
        
    }
    
    func reload(images: [String]) {
        
    }
    
}