//
//  NotificationFooterViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 17.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit

class NotifiCationFooterViewCell: UITableViewCell {
    
    // MARK: - Properties -
    var timeLabel: UIlabel!
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
    
    func setupViews() {
        self.clipsToBounds = true
        
        self.separatorView.mas_key
    }
}