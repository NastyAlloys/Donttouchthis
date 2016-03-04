//
//  NotificationView.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography
import TTTAttributedLabel

class DescriptionView: UIView {
    // MARK: Properties
    private(set) var descriptionLabel: TTTAttributedLabel!
    
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.clipsToBounds = true
        self.setUpDescriptionLabel()
        self.reset()
        self.addSubview(self.descriptionLabel)
        
        constrain(descriptionLabel) { descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.bottom == superview.bottom
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
        }
    }
    
    // MARK: - UIView update -
    func reset() {
        self.descriptionLabel.setText("")
    }
    
    func reload(data: SKBaseActivities) {
        self.descriptionLabel.setText(data.activityDescription.value)
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = TTTAttributedLabel(frame: .zero)
        self.descriptionLabel.linkAttributes = [
            NSForegroundColorAttributeName : UIColor.blueColor()
        ]
        self.descriptionLabel.delegate = self
        self.descriptionLabel.backgroundColor = UIColor.whiteColor()
        self.descriptionLabel.clipsToBounds = true
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
}

extension DescriptionView: TTTAttributedLabelDelegate {
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        guard let url = url else { return }
        UIApplication.sharedApplication().openURL(url)
    }
}