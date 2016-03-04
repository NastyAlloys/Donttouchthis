//
//  InterestDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class ShakeDescriptionView: DescriptionView {
    private(set) var descriptionButton: UIButton!
    
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
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
    }
    
    override func commonInit() {
        super.commonInit()
        self.setUpDescriptionButton()
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
}
