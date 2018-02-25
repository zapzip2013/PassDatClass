//
//  SQLInteract.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

typealias ResQuery = [[String: Any]]
typealias RowQuery = [String:Any]


import Foundation
import DRDatabase


public class SQLInteract{
    //MARK: Propierties
    static let phpFile: URL! = URL(string: "http://159.65.45.70/DRDatabase.php") // e.g. http://213.123.456.567/DRDatabase.php
    static let host: URL! = URL(string: "localhost") // If your database is on the same server as the php file,
    //use 'localhost' , otherwise use the ip address of
    //your database and configure remote access.
    static let databaseName = "PassDatClass" // name of your MySQL database
    static let username = "guest"
    static let password = "jordanrules"
    
    static let connection = DRConnection(host: host, database: databaseName, username: username, password: password)
    static let database = DRDatabase(phpFileUrl: phpFile, connection: connection)
    
    
    //MARK: Methods
    class func ExecuteSelect(query: String) -> [[String:Any]]{
        var ret = ResQuery()
        // execute your command
        database.execute(sqlCommand: query) { (detailedJsonObject, error) in
            if let error = error {
                // some error handling
                print("\(error.errorCode!): \(error.errorDescription!)")
                ret += [["Result":false],["Info": String(error.errorCode) + error.errorDescription]]// Includes URLRequest errors and MySQL syntax/server errors
            }
            if let jsonObject = detailedJsonObject {
                if jsonObject.result?.isEmpty == false {
                    // jsonObject.result! is your data from the database in a [[String:Any]] format
                    print(jsonObject.result! as Any)
                    ret += jsonObject.result!
                } else {
                    // This happens at a INSERT, UPDATE or DELETE command.
                    ret += [["Result":true], ["Info":"All went successfully"]]
                    print("There is no JSON! Command successfully sent and executed by database")
                }
            }
        }
        
        // cancel a running request
        database.abortExecution()
        
        return ret
    }
    
    class func ExecuteModification(query: String) -> (Bool, String) {
        let resquery = ExecuteSelect(query: query).first!
        return (resquery["Result"] as! Bool, resquery["Info"] as! String)
    }
}

