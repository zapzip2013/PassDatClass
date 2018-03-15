//
//  SQLInteract.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//
//
/* Implemented by Jose Carlos */

public typealias ResQuery = [[String: Any]]
public typealias RowQuery = [String:Any]
public typealias StatusMsg = (Bool, String)


import Foundation
import Alamofire
import Alamofire_Synchronous


public class SQLInteract{
    //MARK: Propierties
    static var phpFile: URL! = URL(string: "https://jcquiles.com/DRDatabase.php") // e.g. http://jcquiles.com/DRDatabase.php
    static let host = "localhost" // If your database is on the same server as the php file,
    //use 'localhost' , otherwise use the ip address of
    //your database and configure remote access.
    static let databaseName = "PassDatClass" // name of your MySQL database
    static let username = "tallafoc"
    static let password = "carlos13"
    
    static var parameters = [
        "h" : host,
        "d" : databaseName,
        "u" : username,
        "p" : password
    ]
    
    
    //MARK: Methods
    public class func ExecuteSelect(query: String) -> ([[String:Any]], StatusMsg){
        var ret = ResQuery()
        var status : StatusMsg
        
        parameters["e"] = query
        let response = Alamofire.request(phpFile, method: .post, parameters: parameters).responseJSON()
        
        if let responserror = response.error {
            status = (false, String(describing: responserror))
        }
        else{
            let value = response.data
            do{
                let json = try JSONSerialization.jsonObject(with: value!) as! [[String:Any]]
                ret = json
                status = (true, "Everything is OK")
            } catch {
                status = (false,String(describing: error))
            }
        }
        
        return (ret,status)
    }
    
    public class func ExecuteModification(query: String) -> StatusMsg {
        let resquery = ExecuteSelect(query: query)
        return (resquery.1)
    }
}

