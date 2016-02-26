//
//  File.swift
//  ShakerNotifications
//
//  Created by Andrew on 25.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation

private var vowels: [String] {
    get {
        return ["а","е","ё","и","о","у","ы","э","ю","я"]
    }
}

private var consonants: [String] {
    get {
        return ["б","в","г","д","ж","з","й","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ"]
    }
}

func pluralize(var number: Int, form_for_1: String, form_for_2: String, form_for_5: String) -> String {
    
    number = abs(number) % 100 // берем число по модулю и сбрасываем сотни (делим на 100, а остаток присваиваем переменной number)
    let number_x = number % 10 // сбрасываем десятки и записываем в новую переменную
    if number > 10 && number < 20 { // если число принадлежит отрезку [11;19]
        return form_for_5
    }
    
    if number_x > 1 && number_x < 5 { // иначе если число оканчивается на 2,3,4
        return form_for_2
    }
    
    if number_x == 1 { // иначе если оканчивается на 1
        return form_for_1
    }
    
    return form_for_5
}

var Timestamp: NSTimeInterval {
    return NSDate().timeIntervalSince1970 * 1000
}