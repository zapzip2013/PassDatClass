//
//  Search.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

import Foundation

public class Search {
    //MARK: Properties
    var prefix : String
    var number : Int
    var fsuverifiedfilter: Bool
    var order: Sorting
    
    //MARK: Initializers
    init(prefix: String, number: Int, ver: Bool, order: Sorting = .alph){
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
        let query = "SELECT * FROM tutors WHERE courses LIKE '%" + prefix + "" + String(number) + "%';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        ret += parseResult(resquery)
        let orderret = Sorted.sort(by: order, tutors: ret)
        return orderret
    }
    
    
    
}
