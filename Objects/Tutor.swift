//
//  Tutor.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

import Foundation
import UIKit

public class Tutor : User {
    //MARK: Properties
    var phone : Int
    var email: String
    var name: String
    var rating: Decimal
    var photo: UIImage?
    var code: Int?
    var fsuverified: Bool
    var bio: String
    
    //MARK: Initializers
    init(phone: Int, email: String, name: String, rating: Decimal, photo: UIImage? = nil, verified: Bool, bio: String){
        self.phone = phone
        self.email = email
        self.name = name
        self.rating = rating
        self.photo = photo
        self.fsuverified = verified
        self.bio = bio
    }
    
    init(email: String){
        self.email = email
        //TODO: Retrieve from DB using SQLInteract
        self.phone = 0
        self.name = ""
        self.rating = 0.0
        self.photo = nil
        self.fsuverified = false
        self.bio = ""
    }
    
    //MARK: Methods
    func RequestEdit() {
        //TODO: Generate code automatically
        
        //TODO: Send code to EmailSender
    }
    
    func EditProfile(code: Int) -> Bool {
        if (self.code == code){
            //TODO: Save on DB using SQLInteract
            return true
        }
        else{
            return false
        }
    }
}
