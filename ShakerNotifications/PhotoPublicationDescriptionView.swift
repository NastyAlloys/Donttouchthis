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
    private(set) var lines: CGFloat = 1
    private(set) var layerContainerHeight: NSLayoutConstraint?
    
    
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
            
//            publicationLayer.frame = self.layerContainerView.layer.bounds
            publicationLayer.anchorPoint = CGPoint(x: 0, y: 0)
            publicationLayer.position = CGPoint(x: 1, y: descriptionLabel.frame.height)
            
            let width: CGFloat = self.bounds.width
            let height: CGFloat = 100
            let x: CGFloat = descriptionLabel.frame.minX
            let y: CGFloat = descriptionLabel.frame.height
            
            publicationLayer.frame = CGRect(x: x, y: y, width: width, height: height)
//            self.layerContainerView.layer.backgroundColor = UIColor.clearColor().CGColor
//            
//            self.publicationLayer.setupLayerWithLines(size: CGSize(width: 42, height: 42), offset: 5, maxCount: 12)
//            publicationLayer.bounds.size.width = descriptionLabel.frame.width
//            publicationLayer.bounds.size.height = (viewHeight?.constant)!
        }
    }
    
    private func localInit() {
//        self.clipsToBounds = true
//        self.setupLayerContainerView()
        self.setUpPublicationLayer()
        
        constrain(self.descriptionLabel) { descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
            
        }
        
        /*constrain(self.layerContainerView, self.descriptionLabel) { layerContainerView, descriptionLabel in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
            
            layerContainerView.top == descriptionLabel.bottom + 10
            layerContainerView.left == superview.left
            layerContainerView.bottom == superview.bottom
            layerContainerView.right == superview.right
//            layerContainerHeight = layerContainerView.height == 10
        }*/
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
    }
    
    // TODO make constants
    private func setUpPublicationLayer() {
        self.publicationLayer = SKImageContainerLayer()
        self.publicationLayer.backgroundColor = UIColor.blueColor().CGColor
        self.publicationLayer.setupLayerWithLines(size: CGSize(width: 42, height: 42), offset: 5, maxCount: 12)
//        self.layerContainerView.layer.addSublayer(self.publicationLayer)
        self.layer.addSublayer(self.publicationLayer)
    }
    
    private func updatePublications() {
        var currentWidth: CGFloat = 0
        var currentHeight: CGFloat = 0
        let count = self.publicationData.count!
        
        self.publicationLayer.displayImages(count: count, clear: false) { index, layer in
            layer.contentsGravity = kCAGravityResizeAspect
            layer.cornerRadius = 0.8
            layer.contents = UIImage(named: "icon-notify-like")?.CGImage
            
            print(layer.frame)
            
            currentWidth += layer.bounds.width
            
            if currentWidth >= self.bounds.width {
                currentWidth = 0
                self.lines += CGFloat(1)
            }
        }
        
        print("PUBLICATION LAYER \(publicationLayer.frame)")
        
        // todo make constants
        currentHeight = 42 * lines
        viewHeight?.constant = currentHeight
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p: CGPoint = touches.first!.locationInView(self)
        for layer: CALayer in self.publicationLayer.sublayers! {
            if layer.containsPoint(self.publicationLayer.convertPoint(p, toLayer: layer)) {
                if layer.hidden != true {
                    print("нажали на картиночку")
                }
//                let publicationSourceUrl = NSURL(string: "shaker://interestSource/\(interestData.interest_id)")!
//                UIApplication.sharedApplication().openURL(interestSourceUrl)
            }
        }
    }
}