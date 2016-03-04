//
//  SKFooterContainerView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import SwiftyJSON

class SKFooterContainerView: UIView {
    // MARK: - Properties -
    var timeLabel: UILabel!
    
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
        
        self.configureLabel()
        addSubview(self.timeLabel)
        
        constrain(self.timeLabel) { timeLabel in
            guard let superview = timeLabel.superview else { return }
            
            timeLabel.left == superview.left
            timeLabel.right == superview.right
            timeLabel.top == superview.top
            timeLabel.height == superview.height
        }
    }
    
    // MARK: - UIView configuration -
    private func configureLabel() {
        self.timeLabel = UILabel()
        
        self.timeLabel.backgroundColor = UIColor.whiteColor()
        self.timeLabel.textColor = UIColor.lightGrayColor()
        self.timeLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.timeLabel.font = self.timeLabel.font.fontWithSize(10)
    }
    
    // MARK: - UIView update -
    func reset() {
        
    }
    
    func reload(data: SKBaseActivities) {
        
        let timestamp = data.timestamp
        
        let currentDate = NSDate()
        let serverDate = NSDate(timeIntervalSince1970: timestamp)
        let diffDate = NSDate.feedIntervalBetweenDates(serverDate, nowDate: currentDate)
        
        self.timeLabel.text = diffDate!
    }
    
}