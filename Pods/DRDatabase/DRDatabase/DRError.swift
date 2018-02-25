//
//  DRError.swift
//  DRDatabase
//
//  Created by Daniel Riege on 19/02/2017.
//  Copyright © 2017 Daniel Riege. All rights reserved.
//

import UIKit

public class DRError: NSObject {
    public var errorDescription: String!
    public var errorCode: Int!
    
    required public init(description: String, code: Int) {
        self.errorDescription = description
        self.errorCode = code
    }
}
