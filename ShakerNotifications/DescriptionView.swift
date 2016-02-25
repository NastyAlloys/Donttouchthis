//
//  NotificationView.swift
//  ShakerNotifications
//
//  Created by Andrew on 19.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import SwiftyJSON

class DescriptionView: UIView {
    // MARK: - Initialization -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.clipsToBounds = true
        
    }
    
    // MARK: - UIView update -
    func reset() { }
    
    func reload(json: JSON) {
    
    
    
    }
    
}