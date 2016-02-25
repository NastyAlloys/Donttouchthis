//
//  ActivitesTableViewController.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let users = [
        [
            "images": [
                "avatar",
                "avatar"
            ]
        ], [
            "images": [
                "avatar",
                "avatar",
                "avatar"
            ]
        ], [
            "images": [
                "avatar"
            ]
        ]
        
    ]
    
    var json: JSON = JSON.null
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getJSON()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor.whiteColor()
        
        // register your class with cell identifier
        self.tableView.registerClass(ProfileNotificationCell.self as AnyClass, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json["body"].arrayValue.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellData = json["body"].arrayValue[indexPath.row]
        if let cell = cell as? ProfileNotificationCell {
            cell.reload(cellData)
        }
    }
    
    func getJSON() {
        if let file = NSBundle(forClass:AppDelegate.self).pathForResource("NotificationJSON", ofType: "json") {
            let data = NSData(contentsOfFile: file)!

            json = JSON(data:data)
        } else {
            json = JSON.null
        }
    }
}

extension UIImageView {
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