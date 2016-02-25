//
//  BodyNotificationCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation

class ProfileNotificationCell: NotificationCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return ProfileDescriptionView.self
    }
}