//
//  InterestDescriptionView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class LikeDescriptionView: DescriptionView {
    private(set) var baseData: SKLikeFeedback!
    
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
    
    private func localInit() { }
    
    override func reload(data: SKBaseFeedback) {
        super.reload(data)
        
        switch data.feedbackModelType {
        case .LikeInterest:
            baseData = data as? SKLikeInterestFeedback
        case .LikeQuote:
            baseData = data as? SKLikeQuoteFeedback
        case .LikeShake:
            baseData = data as? SKLikeShakeFeedback
        default:
            baseData = data as? SKLikeFeedback
        }
        
        if baseData.photos == nil {
            setHiddenButtonConstraints()
        } else {
            setVisibleButtonConstraints()
            
            if (baseData.count != nil) {
                self.descriptionButton.backgroundColor = UIColor.whiteColor()
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
                    guard let photos = self?.baseData.photos?[0] else { return }
                    
                    let imageUrl = NSURL(string: photos)
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
        }
    }
    
    // TODO : Сделать метод для перехода в публикацию шейка.
    override func buttonDidTouch(sender: UIButton!) {
//        let interestSourceUrl = NSURL(string: "shaker://interestSource/\(baseData.id)")!
//        UIApplication.sharedApplication().openURL(interestSourceUrl)
    }
}
