//
//  BodyDescriptionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import TTTAttributedLabel
import Cartography
import SwiftyJSON
import Stencil

class ProfileDescriptionView: DescriptionView {
    private(set) var descriptionButton: UIButton!
    private(set) var descriptionLabel: UILabel!
    
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
//        self.descriptionLabel.text = ""
//        self.descriptionButton = nil
    }
    
    override func reload(json: JSON) {
        super.reload(json)
        
//        print(json)
//        print(json["user_names"].count)
        
//        let context = Context(dictionary: [
//            "userNames": json["user_names"]
//        ])
        
        print(json["user_names"].arrayObject)
        
        let array = json["user_names"].arrayObject as! [String]
        
//        var string = ""
//        
//        for name in array {
//            if name != array.last {
//             string += name + ", "
//            } else {
//                string += name
//            }
//        }
//        
//        string += " подписались на "
        
        let pluralize = Filter { (count: Int?, info: RenderingInfo) in
            
            // The inner content of the section tag:
            var string = info.tag.innerTemplateString
            
            // Pluralize if needed:
            if count > 1 {
                string += "s"  // naive
            }
            
            return Rendering(string)
        }
        
        let namespace = Namespace()
        
        namespace.registerFilter("pluralize") { count in
            if let count = count as? Int {
                
                return value * 2
            }
            
            return value
        }

        let context = Context(dictionary: [
            "user_names": array
        ])
        
        do {
            let template = try Template(named: "ProfileDescription.stencil")
            let rendered = try template.render(context)
            print(rendered)
            self.descriptionLabel.textColor = UIColor.whiteColor()
            self.descriptionLabel.font = UIFont(name: self.descriptionLabel.font.fontName, size: 15)
            self.descriptionLabel.text = rendered
        } catch {
            print("Failed to render template \(error)")
        }

        
//        self.descriptionLabel.text = string
        

    }
    
    private func commonInit() {
        self.setUpDescriptionButton()
        self.setUpDescriptionLabel()
        self.reset()
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.descriptionButton)
        
        constrain(descriptionButton, descriptionLabel) { descriptionButton, descriptionLabel in
            guard let superview = descriptionButton.superview else { return }
            
            descriptionButton.width == 35
            descriptionButton.height == 35
            descriptionButton.right == superview.right - 15
            descriptionButton.top == superview.top + 10
            
//            nameLabel.left == superview.left + 10
//            nameLabel.top == superview.top + 10
//            nameLabel.right == descriptionButton.left - 10
            descriptionLabel.top == superview.top + 10
            descriptionLabel.bottom == superview.bottom - 10
            descriptionLabel.left == superview.left + 10
            descriptionLabel.right == descriptionButton.left - 10
            descriptionLabel.height == 100
        }
    }
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.setTitle("SHIT", forState: .Normal)
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.backgroundColor = UIColor.blueColor()
        self.descriptionLabel.clipsToBounds = false
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
}