//
//  BodyFeedbackCell.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

class ProfileFeedbackCell: FeedbackCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return ProfileDescriptionView.self
    }
}