//
//  NotificationRequestsViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 18.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class NotificationRequestsViewCell: UITableViewCell {
    
    // MARK: - Properties -
    var countLabel: UILabel!
    var descriptionLabel: UILabel!
    var iconImageView: UIImageView!
    var arrowImageView: UIImageView!
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
        self.reset()
        
        self.separatorView = UIView()
        self.separatorView.backgroundColor = UIColor.purpleColor()
        
        self.iconImageView = setupIconImageView()
        self.arrowImageView = setupArrowImageView()
        self.descriptionLabel = setupDescriptionLabel()
        self.countLabel = setupCountLabel()
        
        contentView.addSubview(self.separatorView)
        contentView.addSubview(self.iconImageView)
        contentView.addSubview(self.arrowImageView)
        contentView.addSubview(self.descriptionLabel)
        contentView.addSubview(self.countLabel)
        
        constrain(self.separatorView, self.iconImageView, self.arrowImageView, self.descriptionLabel, self.countLabel) {
            separatorView, iconImageView, arrowImageView, descriptionLabel, countLabel in
            guard let superview = separatorView.superview else { return }
            
            separatorView.height == 0.5
            separatorView.bottom == superview.bottom
            separatorView.left == superview.left
            separatorView.right == superview.right
            
            iconImageView.width == 35
            iconImageView.height == 35
            
            arrowImageView.width == 20
            arrowImageView.height == 20
            arrowImageView.left == countLabel.right + 5
            arrowImageView.centerY == superview.centerY
            arrowImageView.right == superview.right - 15
            
            iconImageView.left == superview.left + 15
            iconImageView.centerY == superview.centerY
            
            descriptionLabel.centerY == superview.centerY
            descriptionLabel.left == iconImageView.right + 10
            
            countLabel.centerY == superview.centerY
        }
        
    }
    
    func reset() {
        
    }
    
    // MARK: - Properties Setup -
    func setupIconImageView() -> UIImageView {
        let iconImageView = UIImageView()
        
        iconImageView.backgroundColor = UIColor.whiteColor()
        iconImageView.image = UIImage(named: "notification.description.profile.png")
        iconImageView.contentMode = UIViewContentMode.ScaleAspectFill
        iconImageView.layer.shouldRasterize = true
        iconImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        return iconImageView
    }
    
    func setupArrowImageView() -> UIImageView {
        let arrowImageView = UIImageView()
        
        arrowImageView.backgroundColor = UIColor.whiteColor()
        arrowImageView.image = UIImage(named: "shared.arrow.png")
        arrowImageView.contentMode = UIViewContentMode.Center
        
        return arrowImageView
    }
    
    func setupDescriptionLabel() -> UILabel {
        let descriptionLabel = UILabel()
        
        descriptionLabel.backgroundColor = UIColor.whiteColor()
//        descriptionLabel.font = [UIFont s_Body_P2];
        descriptionLabel.textColor = UIColor.blackColor()
//        descriptionLabel.text = NSLocalizedString("notification.requests.pending", tableName: <#T##String?#>, bundle: <#T##NSBundle#>, value: <#T##String#>, comment: <#T##String#>) NSLocalizedStringFromTable(@"notification.requests.pending", @"NotificationsLocalization", nil);
        descriptionLabel.lineBreakMode = .ByTruncatingTail
        
        return descriptionLabel
    }
    
    func setupCountLabel() -> UILabel {
        let countLabel = UILabel()
        
        self.countLabel.backgroundColor = UIColor.whiteColor()
//        self.countLabel.font = [UIFont s_Body_P2];
        self.countLabel.textColor = UIColor.redColor()
        self.countLabel.text = nil
        
        return countLabel
    }
    
    
}