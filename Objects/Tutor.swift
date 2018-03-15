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
    public var firstname: String
    public var lastname: String
    public var rating: Float
    public var numbervotes: Int
    public var photo: UIImage?
    public var priceperhour: Float
    public var fsuverified: Bool
    public var bio: String
    public var name : String {
        get{
            return lastname + "," + firstname
        }
    }
    
    //MARK: Initializers
    public init(phone: Int, email: String, name: String, lastname: String, rating: Float, numbervotes: Int, photo: UIImage? = nil, price: Float, verified: Bool, bio: String){
        self.phone = phone
        self.email = email
        self.firstname = name
        self.lastname = lastname
        self.rating = rating
        self.numbervotes = numbervotes
        self.photo = photo
        self.priceperhour = price
        self.fsuverified = verified
        self.bio = bio
    }
    
    //MARK: Methods
    class func ParseResult(_ row: RowQuery) -> Tutor {
        let firstname = row["firstName"] as! String
        let lastname = row["lastName"] as! String
        let priceperhour = row["pricePerHour"] as! Float
        let numbervotes = row["numbervotes"] as! Int
        let phone = row["phoneNumber"] as! Int
        let bio = row["bio"] as! String
        let rating = row["rating"] as! Float
        let fsuverified = row["fsuverified"] as! Bool
        let email = row["email"] as! String
        let photo = row["photo"] as? UIImage
        let ret = Tutor(phone: phone, email: email, name: firstname, lastname: lastname, rating: rating, numbervotes: numbervotes, photo: photo, price: priceperhour, verified: fsuverified, bio: bio)
        return ret
    }
    
    class func encrypt(_ pass: String) -> String {
        // TODO
        return pass
    }
    
    class func AddSaltPepper(pass: String) -> String {
        let salt = "DDSADSA;"
        let pepper = "435432!"
        let result = salt + pass + pepper;
        let cryptresult = encrypt(result)
        return cryptresult
    }
    
    class func LogIn(email: String, password: String) -> Bool {
        let query = "SELECT * FROM users WHERE email='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let DBpass = resquery.0.first!["password"] as! String
        let cryptpass = AddSaltPepper(pass: password)
        return cryptpass == DBpass
    }
    
    class func QueryAccount(email: String) -> Tutor {
        let query = "SELECT * FROM tutors WHERE email='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let tutor = Tutor.ParseResult(resquery.0.first!)
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
        //TODO: TABLE USERS? DOUBT
        return SQLInteract.ExecuteModification(query: query)
    }
    
}

