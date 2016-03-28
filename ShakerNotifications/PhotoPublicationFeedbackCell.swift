//
//  PublicationFeedbackCell.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

class PhotoPublicationFeedbackCell: FeedbackCell {
    override func descriptionViewClass() -> DescriptionView.Type {
        return PhotoPublicationDescriptionView.self
    }
}