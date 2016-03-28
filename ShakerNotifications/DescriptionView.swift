//
//  FeedbackView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography
import TTTAttributedLabel

class DescriptionView: UIView {
    // MARK: Properties
    var footerView: SKFooterContainerView!
    private(set) var descriptionData: SKBaseFeedback!
    private(set) var descriptionButton: UIButton!
    private(set) var descriptionLabel: TTTAttributedLabel!
    var viewHeight: NSLayoutConstraint?
    var buttonWidth: NSLayoutConstraint?
    var buttonHeight: NSLayoutConstraint?
    var labelRight: NSLayoutConstraint?
    
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
//            viewHeight = (descriptionView.height == 100 ~ 100)
        }
        super.updateConstraints()
    }
    
    func commonInit() {
        self.footerView = SKFooterContainerView()
        addSubview(self.footerView)
        
        clipsToBounds = true
        setUpDescriptionLabel()
        addSubview(descriptionLabel)
        
        setUpDescriptionButton()
        addSubview(descriptionButton)

        constrain(self.descriptionLabel, self.footerView, self.descriptionButton) { label, footer, button in
            guard let superview = label.superview else { return }
            
            label.top == superview.top
            label.left == superview.left
            
            footer.bottom == superview.bottom
            footer.left == superview.left
            footer.right == superview.right
            footer.height == 15
            
            label.bottom == footer.top
            
//            viewHeight = (superview.height == 10)
        }

    }
    
    // MARK: - UIView update -
    func reset() {
        self.descriptionLabel.setText("")
    }
    
    func reload(data: SKBaseFeedback) {
        self.footerView.reload(data)
        
        descriptionLabel.setText(data.feedbackDescription.value)
//        descriptionLabel.sizeToFit()
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
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
        self.descriptionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        self.descriptionButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        self.descriptionButton.addTarget(self, action: "buttonDidTouch:", forControlEvents: .TouchUpInside)
    }
    
    func setVisibleButtonConstraints() {
        constrain(self.descriptionButton, self.descriptionLabel) { button, label in
            guard let superview = label.superview else { return }
            
            button.height == 42
            button.width == 42
            
            button.top == superview.top
            button.right == superview.right - 15
            label.right == button.left - 10
        }
    }
    
    func setHiddenButtonConstraints() {
        constrain(self.descriptionButton, self.descriptionLabel) { button, label in
            guard let superview = label.superview else { return }
            
            label.right == superview.right - 15
        }
        
    }
    
    func buttonDidTouch(sender: UIButton!) {}
}

extension DescriptionView: TTTAttributedLabelDelegate {
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        guard let url = url else { return }
        UIApplication.sharedApplication().openURL(url)
    }
}