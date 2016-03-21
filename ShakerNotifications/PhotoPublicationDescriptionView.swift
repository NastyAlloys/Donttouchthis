//
//  PublicationCollectionView.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class PhotoPublicationDescriptionView: DescriptionView {
    
    private(set) var descriptionButton: UIButton!
    private(set) var publicationData: SKPublicationActivities!
    private(set) var publicationLayer: SKImageContainerLayer!
    private(set) var layerContainerView: UIView!
    private(set) var mainLayerWidth: CGFloat! = 0
    var lines: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.localInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.localInit()
    }
    
    override func reset() {
        super.reset()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let publicationLayer = self.publicationLayer {
            
            publicationLayer.frame = self.layerContainerView.layer.bounds
            self.layerContainerView.layer.backgroundColor = UIColor.clearColor().CGColor
            
            self.publicationLayer.setupLayerWithLines(size: CGSize(width: 42, height: 42), offset: 5, maxCount: 12)
        }
    }
    
    private func localInit() {
        self.clipsToBounds = true
        self.setupLayerContainerView()
        self.setUpPublicationLayer()
    }

    override func reload(data: SKBaseActivities) {
        super.reload(data)
        if let data = data as? SKPublicationActivities {
            if data.with_photo {
                publicationData = data
                self.setNeedsLayout()
                self.layoutIfNeeded()
                updatePublications()
            }
        }
        
//        descriptionButton.sizeToFit()
//        let height = descriptionLabel.frame.height > descriptionButton.frame.height ? descriptionLabel.frame.height : descriptionButton.frame.height
        self.viewHeight?.constant = 100
    }
    
    private func setUpDescriptionButton() {
        self.descriptionButton = UIButton()
        self.descriptionButton.backgroundColor = UIColor.blackColor()
        self.descriptionButton.layer.shouldRasterize = true
        self.descriptionButton.layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    private func setupLayerContainerView() {
        self.layerContainerView = UIView()
        self.layerContainerView.backgroundColor = UIColor.whiteColor()
        self.layerContainerView.clipsToBounds = true
        self.addSubview(self.layerContainerView)
        
        let height = layerContainerView.bounds.height + self.descriptionLabel.bounds.height
        
        constrain(self.layerContainerView, self.descriptionLabel) { layerContainerView, descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
            descriptionLabel.height == 15
            
            layerContainerView.top == descriptionLabel.bottom
            layerContainerView.left == superview.left
            
            layerContainerView.bottom == superview.bottom
            layerContainerView.right == superview.right
//            viewHeight = (layerContainerView.height == 50)
//            viewHeight?.constant == superview
//            viewHeight?.constant = 100

        }
    }
    
    // TODO make constants
    private func setUpPublicationLayer() {
        self.publicationLayer = SKImageContainerLayer()
        self.publicationLayer.backgroundColor = UIColor.clearColor().CGColor
        self.layerContainerView.layer.addSublayer(self.publicationLayer)
    }
    
    private func updatePublications() {
        var currentWidth: CGFloat = 0
        var currentHeight: CGFloat = 0
        let count = self.publicationData.count!
        
        self.publicationLayer.displayImages(count: count, clear: true) { index, layer in
            layer.contentsGravity = kCAGravityResizeAspect
            layer.cornerRadius = 0.8
            layer.contents = UIImage(named: "icon-notify-like")?.CGImage
            
            currentWidth += layer.bounds.width
            
            if currentWidth >= self.layerContainerView.bounds.width {
                currentWidth = 0
                self.lines += CGFloat(1)
            }
            
            currentHeight += layer.bounds.height
        }
        
        
//        viewHeight?.constant = 10000
        
        print("PUBLICATIONS \(currentHeight)")
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p: CGPoint = touches.first!.locationInView(self)
        for layer: CALayer in self.publicationLayer.sublayers! {
            if layer.containsPoint(self.publicationLayer.convertPoint(p, toLayer: layer)) {
                print("нажали на картиночку")
//                let publicationSourceUrl = NSURL(string: "shaker://interestSource/\(interestData.interest_id)")!
//                UIApplication.sharedApplication().openURL(interestSourceUrl)
            }
        }
    }
}