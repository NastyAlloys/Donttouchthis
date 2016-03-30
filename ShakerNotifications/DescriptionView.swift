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

class DescriptionView: UIView, UIGestureRecognizerDelegate {
    // MARK: Properties
    var footerView: SKFooterContainerView!
    private(set) var descriptionData: SKBaseFeedback!
    private(set) var descriptionButton: UIButton!
    private(set) var descriptionLabel: TTTAttributedLabel!
    var viewHeight: NSLayoutConstraint?
    var labelSuperviewTrailing: NSLayoutConstraint?
    var labelButtonTrailing: NSLayoutConstraint?
    
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
            footer.height == FeedbackConstants.FooterSize.height
            
            label.bottom == footer.top ~ 800
            
            button.height == FeedbackConstants.ButtonSize.height
            button.width == FeedbackConstants.ButtonSize.width
            
            button.top == superview.top
            button.right == superview.right - 15
            labelSuperviewTrailing = (label.right == button.left - 10 ~ 900)
            labelButtonTrailing = (label.right == superview.right ~ 100)
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
        self.descriptionLabel.userInteractionEnabled = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: "nonLinkedPartOfLabelWasTapped:")
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.descriptionLabel.addGestureRecognizer(tap)
        
        descriptionLabel.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue
        self.descriptionLabel.extendsLinkTouchArea = false
        
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
        self.descriptionButton.hidden = false
        labelSuperviewTrailing?.priority = 900
        labelButtonTrailing?.priority = 100
    }
    
    func setHiddenButtonConstraints() {
        self.descriptionButton.hidden = true
        labelSuperviewTrailing?.priority = 100
        labelButtonTrailing?.priority = 900
    }
    
    func buttonDidTouch(sender: UIButton!) {}
    
    func nonLinkedPartOfLabelWasTapped(sender: AnyObject) {
        
//        print(sender)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        print(touch.locationInView(self.descriptionLabel))
        if gestureRecognizer.view == self.descriptionLabel {
            return self.descriptionLabel.containslinkAtPoint(touch.locationInView(self.descriptionLabel))
        }
        
        return true
    }
}


extension DescriptionView: TTTAttributedLabelDelegate {
    
//    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
//        guard let url = url else { return }
//        
//        UIApplication.sharedApplication().openURL(url)
//    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithTextCheckingResult result: NSTextCheckingResult!) {
//        guard let url = url else { return }
//        
//        UIApplication.sharedApplication().openURL(url)
        
        print(result.numberOfRanges)
    }
}