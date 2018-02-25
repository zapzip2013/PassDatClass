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
    
    //MARK: Methods
    func ExecuteQuery() -> Course? {
        //TODO: Use SQLInteract to retrieve the results and then sort them using Sorted.sort() so finally it can return the Course
        return nil
    }
    
    
    
}
