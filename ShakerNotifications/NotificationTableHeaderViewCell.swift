//
//  NotificationTableHeaderViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 18.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import TTTAttributedLabel
import Cartography

class NotificationTableHeaderViewCell: UITableViewCell, TTTAttributedLabelDelegate {
    
    // MARK: - Properties -
    var descriptionLabel: UILabel!
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func setUpViews() {
        self.clipsToBounds = true
        self.reset()
        
        self.separatorView = UIView()
        self.descriptionLabel = UILabel()
        
        self.separatorView.backgroundColor = UIColor.grayColor()
        contentView.addSubview(self.separatorView)
        
        self.reset()
        
        self.descriptionLabel.backgroundColor = UIColor.whiteColor()
//        self.descriptionLabel.font = [UIFont s_Body_D1];
        self.descriptionLabel.textColor = UIColor.grayColor()
        self.descriptionLabel.lineBreakMode = .ByTruncatingTail
        
        self.backgroundColor = UIColor.whiteColor()
        
        constrain(self.separatorView, self.descriptionLabel) { separatorView, descriptionLabel in
            guard let superview = separatorView.superview else { return }
            separatorView.height == ViewConstants.separatorHeight
            descriptionLabel.left == superview.left + 15
            descriptionLabel.centerY == superview.centerY
            descriptionLabel.right == superview.right - 15
            superview.bottom == separatorView.bottom
            superview.right == separatorView.right
            separatorView.left == superview.left
        }
    }
    
    // MARK: - ViewCell Update -
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        // controller openURL
    }
    
    func reset() {
        self.selectionStyle = .None
    }
    
    func reload(description: NSString) {
        self.descriptionLabel.text = description as String
    }
    
    func reloadWithAttributes(text: NSAttributedString) {
//        self.descriptionLabel.setText(text)
    }
    
    func getCellHeight() -> CGFloat {
        return round(20 + 15)
    }
}