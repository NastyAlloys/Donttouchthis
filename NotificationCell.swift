//
//  NotficationBodyViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import Foundation
import Cartography
import SwiftyJSON

class NotificationCell: UITableViewCell {
    // MARK: - Properties -
    var avatarView: SKAvatarContainerView!
    var nameView: SKUserNameContainerView!
    var footerView: SKFooterContainerView!
    private(set) var descriptionView: DescriptionView!
    
    func descriptionViewClass() -> DescriptionView.Type {
        return DescriptionView.self
    }
    
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
    }
    
    private func reset() {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.descriptionView.reset()
        self.avatarView.reset()
        self.footerView.reset()
    }
    
    private func commonInit() {
        self.setUpViews()
        
        self.reset()
    }
    
    func reload(cellData: JSON) {
        self.reset()
        self.avatarView.reload(cellData)
        self.descriptionView.reload(cellData)
        self.footerView.reload(cellData)
    }
    
    /*
        Настройка контейнеров для аватара, описания и
        футера
        Настройка constraints
    */
    private func setUpViews() {
        self.clipsToBounds = true
        
        self.avatarView = SKAvatarContainerView()
        self.footerView = SKFooterContainerView()
        self.descriptionView = self.descriptionViewClass().init()
        
        self.contentView.addSubview(self.avatarView)
        self.contentView.addSubview(self.footerView)
        self.contentView.addSubview(self.descriptionView)
        
        constrain(avatarView, footerView, descriptionView) { avatarView, footerView, descriptionView in
            guard let superview = avatarView.superview else { return }
            
            avatarView.left == superview.left + 10
            avatarView.top == superview.top + 10
            avatarView.bottom == superview.bottom
            descriptionView.bottom == footerView.top - 10
            descriptionView.left == avatarView.right + 10
            descriptionView.right == superview.right - 10 ~ 751
            
//            footerView.height == 10
            footerView.bottom == superview.bottom - 10
            footerView.left == avatarView.right + 10
            footerView.right == superview.right - 10 ~ 751
            
        }
    }
}
