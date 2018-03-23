//
//  User.swift
//  
//
//  Created by Bradley Close on 2018-03-12.
//  Copyright © 2018 Bradley Close. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    var className: String
    
    init(uid:String, username:String,photoURL:URL, className: String) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.className = className
    }
}

