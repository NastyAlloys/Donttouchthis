//
//  SKUserNameContainerView.swift
//  ShakerNotifications
//
//  Created by Andrew on 18.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import SwiftyJSON

class SKUserNameContainerView: UIView {
    // MARK: - Properties -
    var nameLabel: UILabel!
    
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = true
        
        configureNameLabel()
        addSubview(nameLabel)
        
        constrain(nameLabel) { nameLabel in
            guard let superview = nameLabel.superview else { return }
            
            nameLabel.left == superview.left + 10
            nameLabel.top == superview.top + 10
        }
    }
    
    // MARK: - UIView configuration -
    private func configureNameLabel() {
        self.nameLabel = UILabel()
        
        self.nameLabel.backgroundColor = UIColor.grayColor()
        self.nameLabel.clipsToBounds = false
        self.nameLabel.textColor = UIColor.blackColor()
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    // MARK: - UIView update -
    func reset() {
//        self.nameLabel.text = nil
    }
    
    func reload(json: JSON) {
//        self.nameLabel.text = text
    }

}