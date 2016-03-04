//
//  Extensions.swift
//  ShakerNotifications
//
//  Created by Andrew on 29.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NSDate -

extension NSDate {
    
    /*
        Сравнивает текущую и серверную даты и генерирует строку по укзанным условиям, если действие произошло:
        
        - менее минуты назад: "С секунд назад"
        - менее часа назад: "М минут назад"
        - от часа до 3 назад: "Ч час(-а) назад"
        - в текущий день, но более 3-х часов назад: "сегодня в ЧЧ:ММ"
        - в предыдущий день: "вчера в ЧЧ:ММ"
        - более 2-х дней назад, выводится дата действия
    */
    class func feedIntervalBetweenDates(feedDate: NSDate, nowDate: NSDate) -> String? {
        
        let feedTimeInterval: NSTimeInterval = feedDate.timeIntervalSince1970
        let nowTimeInterval: NSTimeInterval = nowDate.timeIntervalSince1970
        
        if nowTimeInterval > feedTimeInterval {
            
            var difference: Int = Int(nowTimeInterval - feedTimeInterval)
            
            let days = Int(abs(difference / 86400))
            
            if days > 0 {
                let daySeconds = days * 86400
                difference = difference - daySeconds
            }
            
            let hours = abs(difference / 3600)
            
            if hours > 0 {
                let hourSeconds = hours * 3600
                difference = difference - hourSeconds
            }
            
            let mins = (abs)(difference / 60)
            
            if mins > 0 {
                let minSeconds = mins * 60
                difference = difference - minSeconds
            }
            
            var results: String = ""
            
            if days < 1 {
                if hours < 1 {
                    if mins < 1 {
                        results += "\(difference) " + pluralize(difference, form_for_1: "секунду", form_for_2: "секунды", form_for_5: "секунд") + " назад"
                    } else {
                        results += "\(mins) " + pluralize(mins, form_for_1: "минуту", form_for_2: "минуты", form_for_5: "минут") + " назад"
                    }
                } else if hours > 1 && hours < 4 {
                    results += "\(hours) " + pluralize(hours, form_for_1: "час", form_for_2: "часа", form_for_5: "часов") + " назад"
                } else {
                    results += "сегодня в \(hours):\(mins >= 10 ? "\(mins)" : ("0" + "\(mins)"))"
                }
            } else if days >= 1 && days < 2 {
                results += "вчера в \(hours):\(mins >= 10 ? "\(mins)" : ("0" + "\(mins)"))"
            } else if days >= 2 {
                results += timestampToDateString(feedTimeInterval)
            }
            
            let trimmedString: String = results.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            return trimmedString
        }
        
        return nil
    }
}


//MARK: - UIImageView -
extension UIImageView {
    /*
        Получает картинку по заданном урлу
    */
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if let e = error {
                    print("Ошибка: \(e.localizedDescription)")
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.image = UIImage(data: data!)
                    })
                    
                }
            }
            task.resume()
        }
    }
}