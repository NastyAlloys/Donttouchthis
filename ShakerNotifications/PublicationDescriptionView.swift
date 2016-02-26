//
//  PublicationCollectionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Cartography

class PublicationDescriptionView: DescriptionView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private(set) var descriptionButton: UIButton!
    private(set) var descriptionLabel: UILabel!
    private(set) var publicationCollectionView: UICollectionView!
    var collection = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func reset() {
        super.reset()
    }
    
    override func reload(json: JSON) {
        super.reload(json)
        
        // получаем картинки публикаций        
        self.collection = [String]()
        self.collection = json["body"]["photos"].arrayObject as! [String]
        
        var publicationString = ""
        let publicationImagesCount = json["body"]["count"].int
        let pluralizedPublicationString = pluralize(publicationImagesCount!, form_for_1: "публикация", form_for_2: "публикации", form_for_5: "публикаций")
        let user_name = json["body"]["user_names"].arrayObject as! [String]
        
        publicationString += "\(user_name[0]) нравится \(publicationImagesCount) \(pluralizedPublicationString)"
    }
    
    private func commonInit() {
        
    }
    
    private func setUpPublicationCollectionView() {
        self.publicationCollectionView = UICollectionView()
        self.publicationCollectionView.scrollsToTop = false
        self.publicationCollectionView.delegate = self
        self.publicationCollectionView.dataSource = self
        self.publicationCollectionView.backgroundColor = UIColor.whiteColor()
        self.publicationCollectionView.bounces = false
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.backgroundColor = UIColor.blueColor()
        self.descriptionLabel.clipsToBounds = false
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
}

extension PublicationDescriptionView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = publicationCollectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let url = collection[indexPath.item]
        let imageView = UIImageView()
        imageView.imageFromUrl(url)
        if let cell = cell as? PhotoCollectionViewCell {
            cell.reloadImage(imageView.image)
        }
    }
}