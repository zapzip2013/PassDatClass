//
//  DRConnection.swift
//  DRDatabase
//
//  Created by Daniel Riege on 18/02/2017.
//  Copyright © 2017 Daniel Riege. All rights reserved.
//

import UIKit

public class DRConnection: NSObject {
    public var host: URL!
    public var database: String!
    public var username: String!
    public var password: String!
    
    required public init(host: URL, database: String, username: String, password: String) {
        self.host = host
        self.database = database
        self.username = username
        self.password = password
    }
}
