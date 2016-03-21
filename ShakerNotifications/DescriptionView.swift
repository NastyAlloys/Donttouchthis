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
    var viewHeight: NSLayoutConstraint?
    
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func updateConstraints() {
        
        constrain(self) { descriptionView in
            viewHeight = descriptionView.height == 10
        }
        super.updateConstraints()
    }
    
    func commonInit() {
        self.clipsToBounds = true
        self.setUpDescriptionLabel()
        self.reset()
        self.addSubview(self.descriptionLabel)
    }
    
    // MARK: - UIView update -
    func reset() {
        self.descriptionLabel.setText("")
    }
    
    func reload(data: SKBaseActivities) {
        self.descriptionLabel.setText(data.activityDescription.value)
        descriptionLabel.sizeToFit()
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
//        descriptionLabel.setContentHuggingPriority(1000, forAxis: UILayoutConstraintAxis.Horizontal)
//        descriptionLabel.setContentCompressionResistancePriority(500, forAxis: UILayoutConstraintAxis.Horizontal)
    }
}

extension DescriptionView: TTTAttributedLabelDelegate {
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        guard let url = url else { return }
        UIApplication.sharedApplication().openURL(url)
    }
}