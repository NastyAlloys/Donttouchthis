//
//  Lazy.swift
//  Shaker2.0
//
//  Created by Sergey Minakov on 10.02.16.
//  Copyright © 2016 ShakerApp. All rights reserved.
//

import UIKit

class Lazy<T> {
    
    private var valueInitializer: () -> T
    private var _value: T?
    var value: T {
        get {
            if self._value == nil {
                self._value = self.valueInitializer()
            }
            
            return self._value!
        }
        set {
            self._value = newValue
        }
    }
    
    var isEmpty: Bool {
        return self._value == nil
    }
    
    init(initializer: (() -> T)) {
        self.valueInitializer = initializer
    }
}
