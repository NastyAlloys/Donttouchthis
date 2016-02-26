//
//  InterestNotificationCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation

class InterestNotificationCell: NotificationCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return InterestDescriptionView.self
    }
}
