//
//  ActivitesTableViewController.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let users = [
        [
            "images": [
                "icon-button-liked",
                "icon-button-liked"
            ]
        ], [
            "images": [
                "icon-button-liked",
                "icon-button-liked",
                "icon-button-liked"
            ]
        ], [
            "images": [
                "icon-button-liked"
            ]
        ]
        
    ]
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor.whiteColor()
        
        // register your class with cell identifier
        self.tableView.registerClass(NotificationBodyViewCell.self as AnyClass, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        print("wiildisplay")
        let cellData = users[indexPath.row]
        if let cell = cell as? NotificationBodyViewCell {
            cell.reload(cellData)
        }
    }
    
    
}