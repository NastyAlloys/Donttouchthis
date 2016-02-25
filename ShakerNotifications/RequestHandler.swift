//
//  RequestHandler.swift
//  ShakerNotifications
//
//  Created by Andrew on 20.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class RequestHandler: NSOperation {
    
    /**
     creates a new HTTP request.
     */
    public init(_ req: NSURLRequest, session: NSURLSession = SharedSession.defaultSession) {
        super.init()
        task = session.dataTaskWithRequest(req)
        DelegateManager.sharedInstance.addResponseForTask(task)
        state = .Ready
    }
    
    /**
     Class method to create a GET request that handles the NSMutableURLRequest and parameter encoding for you.
     */
    public class func GET(url: String, parameters: NSMutableArray? = []) throws -> RequestHandler  {
        
        
    }
    
    public class func parseJSON() {
        
    }
}