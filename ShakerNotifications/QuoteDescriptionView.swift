//
//  QuoteDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class QuoteDescriptionView: DescriptionView {
    private(set) var descriptionButton: UIButton!
    private(set) var quoteData: SKQuoteActivities!
    
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
        
        if let data = data as? SKQuoteActivities {
            
            quoteData = data
            
            if (data.count != nil) {
                self.descriptionButton.backgroundColor = UIColor.whiteColor()
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
                    let imageUrl = NSURL(string: data.photos![0])
                    let imageData = NSData(contentsOfURL: imageUrl!)
                    let image: UIImage = UIImage(data: imageData!)!
                    
                    dispatch_async(dispatch_get_main_queue()) { [weak self] in
                        self?.descriptionButton.setImage(image, forState: .Normal)
                        self?.descriptionButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
                    }
                }
            } else {
                self.descriptionButton.setImage(UIImage(named: ""), forState: .Normal)
                self.descriptionButton.imageView?.contentMode = UIViewContentMode.Center
            }
            
            self.descriptionButton.addTarget(self, action: "quoteButtonTouch:", forControlEvents: .TouchUpInside)
            self.descriptionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
            self.descriptionButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        }
        
        descriptionButton.sizeToFit()
        let height = descriptionLabel.frame.height > descriptionButton.frame.height ? descriptionLabel.frame.height : descriptionButton.frame.height
        self.viewHeight?.constant = height
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
//            descriptionButton.bottom == superview.bottom
            
            descriptionLabel.right == descriptionButton.left - 10
        }
    }
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    func quoteButtonTouch(sender: UIButton!) {
        let interestSourceUrl = NSURL(string: "shaker://quoteSource/\(quoteData.quote_id!)")!
        UIApplication.sharedApplication().openURL(interestSourceUrl)
    }
}
