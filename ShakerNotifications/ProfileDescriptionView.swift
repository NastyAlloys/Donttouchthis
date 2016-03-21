//
//  BodyDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Cartography

class ProfileDescriptionView: DescriptionView {
    
//    var labelHeight: NSLayoutConstraint!
    
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
    }
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
        
//        labelHeight!.constant = descriptionLabel.frame.height
        viewHeight?.constant = descriptionLabel.frame.height
    }
    
    private func localInit() {
        constrain(self.descriptionLabel) { descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.bottom == superview.bottom
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
        }
    }
}
