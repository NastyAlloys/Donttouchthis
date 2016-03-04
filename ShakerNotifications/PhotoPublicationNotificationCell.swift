//
//  PublicationNotificationCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit

class PhotoPublicationNotificationCell: NotificationCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return PhotoPublicationDescriptionView.self
    }
}