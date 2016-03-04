//
//  LikeDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 04.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class LikeDescriptionView: DescriptionView {
    private(set) var descriptionButton: UIButton!
    
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
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.setTitle("SHIT", forState: .Normal)
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
}
