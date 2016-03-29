//
//  CommentDescriptionView.swift
//  ShakerFeedbacks
//
//  Created by Andrey Egorov on 24.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Cartography

class MentionDescriptionView: DescriptionView {
    private(set) var baseData: SKMentionFeedback!
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
    
    override func reload(data: SKBaseFeedback) {
        super.reload(data)
        
        switch data.feedbackModelType {
        case .MentionComment:
            baseData = data as? SKMentionCommentFeedback
        case .MentionPublication:
            baseData = data as? SKMentionPublicationFeedback
        default:
            baseData = data as? SKMentionFeedback
        }
        
        if baseData.with_photo == 1 {
            setVisibleButtonConstraints()
            
            self.descriptionButton.backgroundColor = UIColor.lightGrayColor()
            
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
            setHiddenButtonConstraints()
        }
        
        //        viewHeight?.constant = descriptionLabel.bounds.height
    }
    
    private func localInit() {
    }
}

