//
//  BodyDescriptionView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Cartography

class ProfileDescriptionView: DescriptionView {
    
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
        
        if let data = data as? SKProfileFeedback {
            if data.includes_me == true {
                setVisibleButtonConstraints()
            } else {
                setHiddenButtonConstraints()
            }
        }
    }
    
    private func localInit() {}
}
