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
//        self.nameView.reset()
    }
    
    private func commonInit() {
        self.setUpViews()
        
        self.reset()
    }
    
    func reload(cellData: JSON) {
        self.reset()
        self.avatarView.reload(cellData)
        self.descriptionView.reload(cellData)
//        self.nameView.reload(cellData)
    }
    
    /*
    Настройка контейнеров для аватаров и описания и
    constrain для них
    */
    private func setUpViews() {
        self.clipsToBounds = true
        
        self.avatarView = SKAvatarContainerView()
//        self.nameView = SKUserNameContainerView()
        self.descriptionView = self.descriptionViewClass().init()
        
//        self.contentView.addSubview(self.nameView)
        self.contentView.addSubview(self.avatarView)
        self.contentView.addSubview(self.descriptionView)
        
        constrain(avatarView, descriptionView) { avatarView, descriptionView in
            guard let superview = avatarView.superview else { return }
            
//            nameView.top == superview.top + 10
//            nameView.left == avatarView.right + 10
//            nameView.right == superview.right - 10
//            nameView.bottom == superview.bottom
            
            avatarView.left == superview.left + 10
            avatarView.top == superview.top + 10
            avatarView.bottom == superview.bottom
//            avatarView.right == nameView.right - 10 ~ 751
            
//            descriptionView.top == nameView.bottom + 1
            descriptionView.bottom == superview.bottom - 10
            descriptionView.left == avatarView.right + 10
            descriptionView.right == superview.right - 10
            
//            nameView.height == descriptionView.height
        }
    }
}
