//
//  ShakeNotificationCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation

class ShakeNotificationCell: NotificationCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return ShakeDescriptionView.self
    }
}