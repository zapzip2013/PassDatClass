//
//  DRJSONObject.swift
//  DRDatabase
//
//  Created by Daniel Riege on 18/02/2017.
//  Copyright © 2017 Daniel Riege. All rights reserved.
//

import UIKit

public class DRResultObject: NSObject {
    public var result: [[String:Any]]?
    public var host: String!
    public var database: String!
    public var fetchingDate: NSDate!
}
