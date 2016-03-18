//
//  InterestDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class InterestDescriptionView: DescriptionView {
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
        
        
        
        if let data = data as? SKInterestActivities {
//            let url = NSURL(string: data.photos![0])
//            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//            let image = UIImage(data: data!)
//            //            self.descriptionButton.setIma
//            self.descriptionButton.setImage(image, forState: .Normal)
//            self.descriptionButton.addTarget(self, action: "pushShake:", forControlEvents: .TouchUpInside)
        }
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
