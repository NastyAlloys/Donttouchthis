//
//  ActivitesTableViewController.swift
//  ShakerFeedbacks
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography
import Alamofire

enum SKActivitiesSubtype: String {
    case None, Publication, Shake, Quote, Interest
    
    init(string: String) {
        switch string {
        case "publication":
            self = .Publication
        case "shake":
            self = .Shake
        case "quote":
            self = .Quote
        case "interest":
            self = .Interest
        default:
            self = .None
        }
    }
}

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dataFromJSON: [SKBaseFeedback] = []
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
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = UIColor.whiteColor()
        
        // register your class with cell identifier
        self.tableView.registerClass(ProfileFeedbackCell.self as AnyClass, forCellReuseIdentifier: "profileCell")
        self.tableView.registerClass(PhotoPublicationFeedbackCell.self as AnyClass, forCellReuseIdentifier: "photoPublicationCell")
        self.tableView.registerClass(LikeFeedbackCell.self as AnyClass, forCellReuseIdentifier: "likeCell")
        self.tableView.registerClass(FeedbackCell.self as AnyClass, forCellReuseIdentifier: "feedbackCell")
        
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
        let type = cellData.feedbackType
        let subtype = SKActivitiesSubtype(string: cellData.feedbackSubtype)
        
        var cell = FeedbackCell()
        
        switch type {
        case .Profile:
            cell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileFeedbackCell
        case .Like:
            switch subtype {
            case .Publication:
                cell = tableView.dequeueReusableCellWithIdentifier("photoPublicationCell", forIndexPath: indexPath) as! PhotoPublicationFeedbackCell
            default:
                cell = tableView.dequeueReusableCellWithIdentifier("likeCell", forIndexPath: indexPath) as! LikeFeedbackCell
            }
        default:
            cell = tableView.dequeueReusableCellWithIdentifier("feedbackCell", forIndexPath: indexPath) as! FeedbackCell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellData = self.dataFromJSON[indexPath.row]
                            print(indexPath.row)
        if let cell = cell as? ProfileFeedbackCell {
            cell.reload(cellData)
        } else if let cell = cell as? LikeFeedbackCell {
            cell.reload(cellData)
        } else if let cell = cell as? PhotoPublicationFeedbackCell {
            cell.reload(cellData)
        } else if let cell = cell as? FeedbackCell {
            cell.reload(cellData)
        }
        
        if indexPath.row == ((tableView.indexPathsForVisibleRows?.count)! - 1) && makeItStop == false {
            makeItStop = true
            tableView.reloadData()
        }
    }
    
    // MARK: - Data Fetching Method -
    func getDataFromJSON(callback: (data: [SKBaseFeedback]) -> ()) {
        
        Alamofire.request(.GET, activitiesUrl, parameters: ["device_id": "ADD6F9BF-F514-4605-9184-715C34D23443", "random_key": 1, "crypt": 1, "time": 1])
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                var dataFromJSON: [SKBaseFeedback] = []
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let responseJSON = JSON(value)
                    
                    let array = responseJSON["board"].array ?? []
                    
                    for item in array {
                        guard let feedbackItem = SKBaseFeedback.convert(json: item) else { continue }
                        dataFromJSON.append(feedbackItem)
                    }
                }
                callback(data: dataFromJSON)
        }
    }
    
}