//
//  CommentFeedbackcell.swift
//  ShakerFeedbacks
//
//  Created by Andrey Egorov on 24.03.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

class CommentFeedbackCell: FeedbackCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return CommentDescriptionView.self
    }
}