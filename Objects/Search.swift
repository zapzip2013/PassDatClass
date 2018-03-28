//
//  Search.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//
/* Implemented by Jose Carlos & Jordan Mussman */

import Foundation

public class Search {
    //MARK: Properties
    var prefix : String
    var number : Int
    var fsuverifiedfilter: Bool
    var order: Sorting
    
    //MARK: Initializers
    init(prefix: String, number: Int, ver: Bool, order: Sorting = .lastnamealph){
        self.prefix = prefix
        self.number = number
        self.fsuverifiedfilter = ver
        self.order = order
    }
    
    func parseResult(_ res: ResQuery) -> [Tutor] {
        var ret = [Tutor]()
        
        for row in res {
            ret += [Tutor.ParseResult(row)]
        }
        return ret
    }
    
    //MARK: Methods
    func ExecuteQuery() -> [Tutor] {
        var ret = [Tutor]()
        var course = self.prefix + String(self.number)
        let query = "SELECT * FROM tutor WHERE tutor.bio LIKE '%\(course)%';"//" = '\(course)';"
        //let query = "UPDATE Tutor SET firstName='\(tutor.firstname)', lastName='\(tutor.lastname)', phoneNumber=\(tutor.phone), rating=\(tutor.rating), numberVotes=\(tutor.numbervotes), pricePerHour=\(tutor.priceperhour), bio='\(tutor.bio)'  WHERE FSUEmail='\(tutor.email)';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        ret += parseResult(resquery.0)
        let orderret = Sorted.sort(by: order, tutors: ret)
        return orderret
    }
    
} /* End Search class */
