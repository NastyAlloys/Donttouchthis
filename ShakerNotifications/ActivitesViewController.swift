//
//  ActivitesTableViewController.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography
import Alamofire

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dataFromJSON: [SKBaseActivities] = []
    var tableView = UITableView()
    var request: Request!
    let activitiesUrl = "https://stagingapi.shakerapp.ru/v10/feedback/activities"
    var makeItStop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        tableView.backgroundColor = UIColor.whiteColor()
        
        // register your class with cell identifier
        self.tableView.registerClass(ProfileNotificationCell.self as AnyClass, forCellReuseIdentifier: "profileCell")
        self.tableView.registerClass(PhotoPublicationNotificationCell.self as AnyClass, forCellReuseIdentifier: "photoPublicationCell")
        self.tableView.registerClass(InterestNotificationCell.self as AnyClass, forCellReuseIdentifier: "interestCell")
        self.tableView.registerClass(NotificationCell.self as AnyClass, forCellReuseIdentifier: "notificationCell")
        self.tableView.registerClass(QuoteNotificationCell.self as AnyClass, forCellReuseIdentifier: "quoteCell")
        self.tableView.registerClass(ShakeNotificationCell.self as AnyClass, forCellReuseIdentifier: "shakeCell")
        
        self.view.addSubview(tableView)
        
        self.getDataFromJSON({dataFromJSON in
            self.dataFromJSON = dataFromJSON
            self.tableView.reloadData()
        })
    }
    
    // MARK: - UITableViewDelegate -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFromJSON.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellData = self.dataFromJSON[indexPath.row]
        let type = cellData.activityType
        let subtype = cellData.activitySubtype
        
        var cell = NotificationCell()
        
        switch type {
        case .Profile:
            cell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileNotificationCell
        case .Like:
            switch subtype {
            case .LikeInterest:
                cell = tableView.dequeueReusableCellWithIdentifier("interestCell", forIndexPath: indexPath) as! InterestNotificationCell
            case .LikeShake:
                cell = tableView.dequeueReusableCellWithIdentifier("shakeCell", forIndexPath: indexPath) as! ShakeNotificationCell
            case .LikeQuote:
                cell = tableView.dequeueReusableCellWithIdentifier("quoteCell", forIndexPath: indexPath) as! QuoteNotificationCell
            case .LikePublication:
                cell = tableView.dequeueReusableCellWithIdentifier("photoPublicationCell", forIndexPath: indexPath) as! PhotoPublicationNotificationCell
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath) as! NotificationCell
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath) as! NotificationCell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        let cellData = self.dataFromJSON[indexPath.row]
                
        if let cell = cell as? ProfileNotificationCell {
            cell.reload(cellData)
        } else if let cell = cell as? InterestNotificationCell {
            cell.reload(cellData)
        } else if let cell = cell as? PhotoPublicationNotificationCell {
            cell.reload(cellData)
        } else if let cell = cell as? NotificationCell {
            cell.reload(cellData)
        } else if let cell = cell as? QuoteNotificationCell {
            cell.reload(cellData)
        } else if let cell = cell as? ShakeNotificationCell {
            cell.reload(cellData)
        }
        
        if indexPath.row == ((tableView.indexPathsForVisibleRows?.count)! - 1) && makeItStop == false {
            makeItStop = true
            tableView.reloadData()
        }
    }
    
    // MARK: - Data Fetching Method -
    func getDataFromJSON(callback: (data: [SKBaseActivities]) -> ()) {
        
        Alamofire.request(.GET, activitiesUrl, parameters: ["device_id": "ADD6F9BF-F514-4605-9184-715C34D23443", "random_key": 1, "crypt": 1, "time": 1])
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                var dataFromJSON: [SKBaseActivities] = []
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let responseJSON = JSON(value)
                    
                    let array = responseJSON["body"].array ?? []
                    
                    for item in array {
                        guard let activityItem = SKBaseActivities.convert(json: item) else { continue }
                        dataFromJSON.append(activityItem)
                    }
                }
                callback(data: dataFromJSON)
        }
    }
    
}