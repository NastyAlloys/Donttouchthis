//
//  PublicationCollectionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography

class PhotoPublicationDescriptionView: DescriptionView, UICollectionViewDelegateFlowLayout {
    
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
    
    private func commonInit() {
        
        self.setUpPublicationCollectionView()
        self.reset()
        self.addSubview(self.publicationCollectionView)
        
        self.publicationCollectionView.registerClass(PhotoCollectionViewCell.self as AnyClass, forCellWithReuseIdentifier: "photoCollectionCell")
        
        constrain(self.publicationCollectionView) { publicationCollectionView in
            guard let superview = publicationCollectionView.superview else { return }
            publicationCollectionView.right == superview.right - 15
            publicationCollectionView.bottom == superview.bottom
            publicationCollectionView.left == superview.left
            publicationCollectionView.top == superview.top
            publicationCollectionView.height == 40
        }
    }
    
    private func setUpPublicationCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(42, 42)
        self.publicationCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.publicationCollectionView.scrollsToTop = false
        self.publicationCollectionView.delegate = self
        self.publicationCollectionView.dataSource = self
        self.publicationCollectionView.backgroundColor = UIColor.whiteColor()
        self.publicationCollectionView.bounces = false
        self.publicationCollectionView.delegate = self
        self.publicationCollectionView.dataSource = self
    }
    
    private func setUpDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.backgroundColor = UIColor.blueColor()
        self.descriptionLabel.clipsToBounds = false
        self.descriptionLabel.textColor = UIColor.lightGrayColor()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
    }
    
    override func reset() {
        super.reset()
    }
    
    override func reload(json: JSON) {
        super.reload(json)
        
        // получаем картинки публикаций
        self.collection = [String]()
        self.collection = json["body"]["photos"].arrayObject as! [String]
        
        self.publicationCollectionView.reloadData()
        
        var publicationString = ""
        let publicationImagesCount = json["body"]["count"].int
        let pluralizedPublicationString = pluralize(publicationImagesCount!, form_for_1: "публикация", form_for_2: "публикации", form_for_5: "публикаций")
        let user_name = json["user_names"].arrayObject as! [String]
        
        publicationString += "\(user_name[0]) нравится \(publicationImagesCount) \(pluralizedPublicationString)"
    }
    
    class func getCellHeightForCollectionCount(count: Int, andOrientation orientation: UIDeviceOrientation) -> CGFloat {
        if count < 2 {
            return 0
        }
        
        if orientation.isPortrait {
            let width: CGFloat = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height) - 75
            return self.getBlockHeight(width, count: count)
        } else if orientation.isLandscape {
            let width: CGFloat = max(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height) - 75
            return self.getBlockHeight(width, count: count)
        }
        
        return 0
    }
    
    class func getBlockHeight(width: CGFloat, count: Int) -> CGFloat {
        let countInRow = floor(width / 40)
        let rows = round(Float(count) / Float(countInRow) + 0.45)
        let roundValue = round(rows * 40)
        
        return CGFloat(roundValue)
    }
}

extension PhotoPublicationDescriptionView: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = publicationCollectionView.dequeueReusableCellWithReuseIdentifier("photoCollectionCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let url = collection[indexPath.item]
        if let cell = cell as? PhotoCollectionViewCell {
            cell.reload(url)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 42, height: 42)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
}