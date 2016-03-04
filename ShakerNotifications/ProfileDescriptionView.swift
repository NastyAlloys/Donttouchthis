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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func reset() {
        super.reset()
        
    }
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
        
    }
    
    override func commonInit() {
        super.commonInit()
    }
}
