//
//  LikeFeedbackCell.swift
//  ShakerFeedbacks
//
//  Created by Andrey Egorov on 24.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

class LikeFeedbackCell: FeedbackCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return LikeDescriptionView.self
    }
}