//
//  Course.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

import Foundation

public class Course{
    //MARK: Properties
    var prefix : String
    var number : Int
    var tutors: [Tutor] = []
    
    //MARK: Initializers
    init(prefix: String, number: Int, tutors: [Tutor]){
        self.prefix = prefix
        self.number = number
        self.tutors = tutors
    }
}
