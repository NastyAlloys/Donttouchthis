//
//  PhotoTextDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 04.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit

class PhotoTextDescriptionView: DescriptionView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func commonInit() {
        super.commonInit()
        
        
    }
    
    override func reset() {
        super.reset()
    }
    
    override func reload(data: SKBaseActivities) {
        super.reload(data)
    }
    
}