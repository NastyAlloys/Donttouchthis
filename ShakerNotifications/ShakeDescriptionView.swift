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
        
        self.localInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.localInit()
    }
    
    override func reset() {
        super.reset()
        
//        self.descriptionButton.imageView?.image = nil
    }
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
        
        descriptionButton.sizeToFit()
        let height = descriptionLabel.frame.height > descriptionButton.frame.height ? descriptionLabel.frame.height : descriptionButton.frame.height
        viewHeight?.constant = height
    }
    
    private func localInit() {
        self.setUpDescriptionButton()
        self.addSubview(self.descriptionButton)
        
        constrain(self.descriptionLabel, self.descriptionButton) { descriptionLabel, descriptionButton in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            
            descriptionButton.width == 35
            descriptionButton.height == 35
            
            descriptionButton.right == superview.right - 15
            descriptionButton.top == superview.top
//            descriptionButton.bottom == superview.bottom + 15
            
            descriptionLabel.right == descriptionButton.left - 10
            descriptionLabel.bottom == superview.bottom
        }
    }
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.setImage(UIImage(named: "no-photo"), forState: .Normal)
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        self.descriptionButton.addTarget(self, action: "pushShake:", forControlEvents: .TouchUpInside)
    }
}
