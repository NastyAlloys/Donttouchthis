//
//  SKImageContainerLayer.swift
//  Shaker2.0
//
//  Created by Sergey Minakov on 03.12.15.
//  Copyright © 2015 ShakerApp. All rights reserved.
//

import UIKit

class SKImageContainerLayer: CALayer {
    
    override var frame: CGRect {
        didSet {
            if let sublayers = self.sublayers {
                for layer in sublayers.reverse() where
                    layer.frame.maxX > self.frame.width
                        && !layer.hidden {
                            layer.hidden = true
                }
            }
        }
    }
    
    func reset() {
        if let sublayers = self.sublayers {
            for layer in sublayers where !layer.hidden {
                layer.hidden = true
            }
        }
    }
    
    /*
    П
    */
    func displayImages(count count: Int, clear: Bool, layerSetupBlock: ((index: Int, layer: CALayer) -> ()) ) {
        guard let sublayers = self.sublayers else { return }
        for (index, avatarLayer) in sublayers.enumerate() where
            avatarLayer.frame.maxX <= self.frame.width {
//                print("avatar: \(avatarLayer.frame.maxX)")
//                print("frame: \(self.frame.width)")
                if clear {
                    avatarLayer.contents = nil
                }
                if index < count {
                    avatarLayer.hidden = false
                    layerSetupBlock(index: index, layer: avatarLayer)
                } else if !avatarLayer.hidden {
                    avatarLayer.hidden = true
                }
        }
    }
    
    func dispayImage(image: UIImage?, atIndex index: Int) {
        guard let sublayers = self.sublayers where index >= 0 && index < sublayers.count else { return }
        let layer = sublayers[index]
        guard !layer.hidden else { return }
        layer.contents = image?.CGImage
    }
    
    func setupLayer(size size: CGSize, offset: CGFloat, maxCount: Int) {
        self.masksToBounds = true
        self.backgroundColor = UIColor.clearColor().CGColor
        
        if let sublayers = self.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
        
        let width: CGFloat = size.width + offset
        let cornerRadius: CGFloat = min(size.height, size.width) / 2
        
        for i in 0..<maxCount {
            let avatarLayer = CALayer()
            avatarLayer.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
            avatarLayer.contentsGravity = kCAGravityResizeAspectFill
            avatarLayer.frame = CGRect(x: width * CGFloat(i), y: 0, width: size.width, height: size.height)
            avatarLayer.cornerRadius = cornerRadius
            avatarLayer.masksToBounds = true
            avatarLayer.hidden = true
            avatarLayer.drawsAsynchronously = true
            
            self.addSublayer(avatarLayer)
        }
    }
    
    func setupLayerWithLines(size size: CGSize, offset: CGFloat, maxCount: Int) {
        
        self.masksToBounds = true
        self.backgroundColor = UIColor.clearColor().CGColor
        if let sublayers = self.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
        
        let width: CGFloat = size.width + offset
        let cornerRadius: CGFloat = min(size.height, size.width) / 2
        
        var currentWidth: CGFloat = 0

        var axisY: CGFloat = self.frame.origin.y
        var axisX: CGFloat = 0
        var j = 0
        
//print("SELFBOUNDS \(self.bounds)")
        for _ in 0..<maxCount {
            if currentWidth + width + 15 >= self.bounds.width {
                currentWidth = 0
                axisX = 0
                axisY += size.height + offset
                j = 0
            }
            
            axisX = width * CGFloat(j)
            
            j += 1
            
//            print("currentwidth: \(currentWidth)")
//            print("axisY: \(axisY)")
//            print("axisX: \(axisX)")
            
            let avatarLayer = CALayer()
            avatarLayer.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
            avatarLayer.contentsGravity = kCAGravityResizeAspectFill
            avatarLayer.frame = CGRect(x: axisX, y: axisY, width: size.width, height: size.height)
            avatarLayer.cornerRadius = cornerRadius
            avatarLayer.masksToBounds = true
            avatarLayer.hidden = true
            avatarLayer.drawsAsynchronously = true
            avatarLayer.contents = UIImage(named: "icon-notify-like")?.CGImage
            
//            print("avatarLayerFrame: \(avatarLayer.frame)")
            
            self.addSublayer(avatarLayer)
//            print("FRAMEMEME \(self.frame)")
            currentWidth += avatarLayer.frame.width
            
        }
    }
}