//
//  PublicationCollectionView.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import Cartography

class PhotoPublicationDescriptionView: DescriptionView {
    private(set) var publicationData: SKLikePublicationFeedback!
    private(set) var publicationLayer: SKImageContainerLayer!
    private(set) var layerContainerView: UIView!
    private(set) var lines: Int = 1
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
            
            publicationLayer.anchorPoint = CGPoint(x: 0, y: 0)
            publicationLayer.position = CGPoint(x: 1, y: descriptionLabel.frame.height)
            
            let width: CGFloat = self.layerContainerView.bounds.width
            let height: CGFloat = self.layerContainerView.bounds.height
            
            let x: CGFloat = layerContainerView.frame.minX
            let y: CGFloat = descriptionLabel.frame.minY
            publicationLayer.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    private func localInit() {
        self.setupLayerContainerView()
        self.setUpPublicationLayer()
        layerContainerView.layer.addSublayer(publicationLayer)
    }

    override func reload(data: SKBaseFeedback) {
        super.reload(data)
        if let data = data as? SKLikePublicationFeedback {
            publicationData = data
            
            if data.with_photo > 1 {
                updatePublications()
            } else if data.with_photo == 1 {
                updatePublication()
            }
        }
    }
    
    // TODO make constants
    private func setUpPublicationLayer() {
        self.publicationLayer = SKImageContainerLayer()
        self.publicationLayer.backgroundColor = UIColor.blueColor().CGColor
        
        var width: CGFloat = self.bounds.width
        let screenRect = UIScreen.mainScreen().bounds
        
        width = screenRect.width - 45
        publicationLayer.frame.size.width = width
        
        self.publicationLayer.setupLayerWithLines(size: CGSize(width: 42, height: 42), offset: 5, maxCount: 12)
    }
    
    private func updatePublications() {
        var currentWidth: CGFloat = 0
        var currentHeight: CGFloat = 0
        let count = self.publicationData.with_photo
        lines = 1
        
        self.publicationLayer.displayImages(count: count, clear: false) { index, layer in
            layer.contentsGravity = kCAGravityResizeAspect
            layer.cornerRadius = 0.8
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
                guard let photos = self?.publicationData.photos?[0] else { return }
                
                let imageUrl = NSURL(string: photos)
                let imageData = NSData(contentsOfURL: imageUrl!)
                let image: UIImage = UIImage(data: imageData!)!
                
                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                    self?.layer.contents = image.CGImage
                }
            }
            
            currentWidth += 42
            
            if currentWidth >= self.publicationLayer.bounds.width {
                self.lines += 1
                currentWidth = 0
            }
        }
        
        // todo make constants
        currentHeight = CGFloat((42 * lines) + 5)
        layerContainerHeight!.constant = currentHeight
    }
    
    private func updatePublication() {
        setVisibleButtonConstraints()
        
        self.descriptionButton.backgroundColor = UIColor.lightGrayColor()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] in
            guard let photos = self?.publicationData.photos?[0] else { return }
            
            let imageUrl = NSURL(string: photos)
            let imageData = NSData(contentsOfURL: imageUrl!)
            let image: UIImage = UIImage(data: imageData!)!
            
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.descriptionButton.setImage(image, forState: .Normal)
                self?.descriptionButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
            }
        }
    }
    
    private func setupLayerContainerView() {
        self.layerContainerView = UIView()
        self.layerContainerView.backgroundColor = UIColor.whiteColor()
        self.layerContainerView.clipsToBounds = true
        self.addSubview(self.layerContainerView)
        
        constrain(self.layerContainerView, self.descriptionLabel, self.footerView) { layerContainerView, descriptionLabel, footerView in
            guard let superview = descriptionLabel.superview else { return }
            
            descriptionLabel.top == superview.top
            descriptionLabel.left == superview.left
            descriptionLabel.right == superview.right
            
            layerContainerView.top == descriptionLabel.bottom + 10
            layerContainerView.left == superview.left
            
            layerContainerView.bottom == footerView.top
            layerContainerView.right == superview.right
            layerContainerHeight = (layerContainerView.height == 0)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p: CGPoint = touches.first!.locationInView(self)
        for layer: CALayer in self.publicationLayer.sublayers! {
            if layer.containsPoint(self.publicationLayer.convertPoint(p, toLayer: layer)) {
                if layer.hidden != true {
//                let publicationSourceUrl = NSURL(string: "shaker://interestSource/\(interestData.interest_id)")!
//                UIApplication.sharedApplication().openURL(interestSourceUrl)
                    print("нажали на картиночку")
                }
            }
        }
    }
}