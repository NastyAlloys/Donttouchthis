//
//  NotificationFooterViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 17.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import SwiftyJSON

class NotifiCationFooterViewCell: UITableViewCell {
    
    // MARK: - Properties -
    var timeLabel: UILabel!
    var separatorView: UIView!
    
    // MARK: - Initialization -
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpViews()
    }
    
    func setUpViews() {
        self.clipsToBounds = true
        
        self.separatorView = UIView()
        self.timeLabel = UILabel()
        
        self.separatorView.backgroundColor = UIColor.grayColor()
        contentView.addSubview(self.separatorView)
        
        self.reset()
        
        self.timeLabel.backgroundColor = UIColor.whiteColor()
        self.timeLabel.textColor = UIColor.grayColor()
//        self.timeLabel.font = nil
        self.timeLabel.lineBreakMode = .ByTruncatingTail
        contentView.addSubview(self.timeLabel)
        
        constrain(self.separatorView, self.timeLabel) { separatorView, timeLabel in
            guard let superview = separatorView.superview else { return }
            separatorView.height == ViewConstants.separatorHeight
            separatorView.left == superview.left
            separatorView.bottom == superview.bottom
            separatorView.right == superview.right
            timeLabel.left == superview.left + 60
            timeLabel.right == superview.right - 15
            timeLabel.top == superview.top
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.selectionStyle = .None
    }
    
    func reload(json: JSON) {
        self.timeLabel.text = "timestring"
    }
    
    func getCellHeight() -> CGFloat {
        return round(15 + 10)
    }
    
}