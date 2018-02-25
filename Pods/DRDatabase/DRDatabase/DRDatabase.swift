//
//  DRDatabase.swift
//  DRDatabase
//
//  Created by Daniel Riege on 18/02/2017.
//  Copyright © 2017 Daniel Riege. All rights reserved.
//

import UIKit

public class DRDatabase: NSObject {
    
    var phpFileUrl: URL!
    var connection: DRConnection!
    var executionTask: URLSessionDataTask?
    
    required public init(phpFileUrl: URL, connection: DRConnection) {
        self.phpFileUrl = phpFileUrl
        self.connection = connection
    }
    
    public func execute(sqlCommand: String, serverResponse: @escaping (_ jsonObject: DRResultObject?, _ error: DRError?) -> Void) -> Void {
        if connection != nil {
            var executionRequest = URLRequest(url: self.phpFileUrl)
            executionRequest.httpMethod = "POST"
            let host = connection.host!
            let database = connection.database!
            let username = connection.username!
            let password = connection.password!
            let postString = String(format: "h=%@&d=%@&u=%@&p=%@&e=%@",host as CVarArg ,database ,username ,password ,sqlCommand)
            executionRequest.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: executionRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    serverResponse(nil, DRError(description: (error?.localizedDescription)!, code: (error as! NSError).code))
                    return
                }
                guard let data = data else {
                    serverResponse(nil, nil)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]]
                    let responseJsonObject = DRResultObject()
                    
                    if (self.checkSQLError(json: json)) {
                        let sqlError = json![0]["error"] as! [String:Any]
                        let error = DRError(description: sqlError["description"] as! String, code: sqlError["code"] as! Int)
                        serverResponse(nil, error)
                        return
                    }
                    
                    responseJsonObject.host = String(describing: self.connection.host)
                    responseJsonObject.database = self.connection.database
                    responseJsonObject.fetchingDate = NSDate()
                    responseJsonObject.result = json
                    serverResponse(responseJsonObject, nil)
                } catch {
                    serverResponse(nil, DRError(description: (error as NSError).localizedDescription, code: (error as NSError).code))
                    return
                }
            })
            self.executionTask = task
            task.resume()
        } else {
            serverResponse(nil, nil)
            return
        }
    }
    
    public func abortExecution() {
        if executionTask != nil {
            executionTask?.cancel()
        }
    }
    
    private func checkSQLError(json: [[String:Any]]?) -> Bool {
        if json?.isEmpty == false {
            if let item = json?[0] {
                if item["error"] != nil {
                    return true
                }
            }
        }
        return false
    }
}
