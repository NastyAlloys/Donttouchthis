//
//  PhotoCollectionViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 26.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties -
    var useCornerRadius: Bool!
    var timestamp: NSTimeInterval!
    var photoImageView: UIImageView!
    
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setUpViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (self.useCornerRadius != nil) {
            self.photoImageView.layer.cornerRadius = 2.5
        } else {
            self.photoImageView.layer.cornerRadius = 0
        }
        
        self.photoImageView.clipsToBounds = true
    }
    
    private func commonInit() {
        self.setUpViews()
        
        self.reset()
    }
    
    private func setUpViews() {
        self.useCornerRadius = true
        
        self.photoImageView.backgroundColor = UIColor.whiteColor()
        self.photoImageView.image = nil
        self.photoImageView.contentMode = UIViewContentMode.ScaleAspectFill
    }
    
    private func reset() {
        self.photoImageView.image = nil
    }
    
    func prepareForReload() {
        self.timestamp = NSDate().timeIntervalSince1970
    }
    
    func setColorBackground(backgroundColor: UIColor) {}
    
    func reloadImage(image: UIImage?) {
        self.photoImageView.image = image ?? UIImage(named: "no-photo")
        
        if let _ = image {
            self.photoImageView.contentMode = UIViewContentMode.ScaleAspectFill
        } else {
            self.photoImageView.contentMode = UIViewContentMode.Center
        }
        
    }
    
    func reloadImage(image: UIImage, timestamp: NSTimeInterval) {
        if self.timestamp != timestamp {
             return
        }
        
        self.reloadImage(image)
    }
    
    func reload(collection: [String]) {
        self.layoutIfNeeded()
        
        self.timestamp = NSDate().timeIntervalSince1970
        
        let timestamp: NSTimeInterval = self.timestamp
        var image = UIImage()
        
        if self.timestamp != timestamp {
            return
        }
        
//        for imageString in collection {
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                image = image.
//                self.reloadImage()
//            })
//        }
        
        
        
        
    }
    
}