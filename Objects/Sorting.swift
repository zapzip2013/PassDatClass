//
//  Sorting.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

import Foundation

enum Sorting{
    case alph
    case rating
    case lastadded
    case lastnamealph
    case firstwithphoto
}

public class Sorted{
    class func sort(by: Sorting, tutors: [Tutor]){
        switch(by){
        case .alph:
            print("")
        case .rating:
            print("")
        case .lastadded:
            print("")
        case .lastnamealph:
            print("")
        case .firstwithphoto:
            print("")
            //TODO: And so on...
        }
    }
}
