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
    public var phone : Int
    public var email: String
    public var name: String
    public var rating: Int
    public var photo: UIImage?
    public var code: Int?
    public var fsuverified: Bool
    public var bio: String
    
    //MARK: Initializers
    public init!(phone: Int, email: String, name: String, rating: Int, photo: UIImage? = nil, verified: Bool, bio: String){
        self.phone = phone
        self.email = email
        self.name = name
        self.rating = rating
        self.photo = photo
        self.fsuverified = verified
        self.bio = bio
    }
    
    public init(email: String){
        self.email = email
        //TODO: Retrieve from DB using SQLInteract
        self.phone = 0
        self.name = ""
        self.rating = 0
        self.photo = nil
        self.fsuverified = false
        self.bio = ""
    }
    
    //MARK: Methods
    class func ParseResult(_ row: RowQuery) -> Tutor {
        let firstname = row["firstName"] as! String
        let lastname = row["lastName"] as! String
        //let priceperhour = row["pricePerHour"] as! Double
        let phone = row["phoneNumber"] as! Int
        let bio = row["bio"] as! String
        let rating = row["rating"] as! Int
        let fsuverified = row["fsuverified"] as! Bool
        let email = row["email"] as! String
        let ret = Tutor(phone: phone, email: email, name: lastname+","+firstname, rating: rating, verified: fsuverified, bio: bio)
        return ret!
    }
    
    class func QueryAccount(email: String) -> Tutor {
        let query = "SELECT * FROM tutors WHERE email='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let tutor = Tutor.ParseResult(resquery.first!)
        return tutor
    }
    
    class func EditAccount(tutor: Tutor) -> (Bool,String) {
        //TODO
        let query = "UPDATE tutors VALUES (..) WHERE email='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func DeleteAccount(tutor: Tutor) -> (Bool,String)  {
        let query = "DELETE FROM tutors WHERE email='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func CreateAccount(tutor: Tutor) -> (Bool,String) {
        let query = "INSERT INTO tutors VALUES (...);"
        return SQLInteract.ExecuteModification(query: query)
    }
    
}

