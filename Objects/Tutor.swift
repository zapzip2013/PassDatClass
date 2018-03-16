//
//  Tutor.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

/* Implemented by Jose Carlos */


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
        let firstname = row["FirstName"] as! String
        let lastname = row["LastName"] as! String
        let priceperhour = row["PricePerHour"] as! Float
        let numbervotes = row["NumberVotes"] as! Int
        let phone = row["Phone"] as! Int
        let bio = row["Bio"] as! String
        let rating = row["Rating"] as! Float
        let fsuverified = row["FSUVerified"] as! Bool
        let email = row["FSUEmail"] as! String
        let photo = SQLInteract.base64ToImage(base64: row["Photo"] as? String)
        let ret = Tutor(phone: phone, email: email, name: firstname, lastname: lastname, rating: rating, numbervotes: numbervotes, photo: photo, price: priceperhour, verified: fsuverified, bio: bio)
        return ret
    }
    
    class func encrypt(_ pass: String) -> String {
        return pass
    }
    
    
    class func AddSaltPepper(pass: String) -> String {
        let salt = "DDSADSA;"
        let pepper = "435432!"
        let result = salt + pass + pepper;
        let cryptresult = encrypt(result)
        return cryptresult
    }
    
    class func LogIn(email: String, password: String) -> StatusMsg {
        let query = "SELECT * FROM User WHERE FSUEmail='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let msg = resquery.1
        if msg.status == false {
            return msg
        }
        else if (resquery.0.isEmpty){
            return (false, "There's no such username registered!")
        }
        else {
            let DBpass = resquery.0.first!["Password"] as! String
            let cryptpass = AddSaltPepper(pass: password)
            if (cryptpass == DBpass){
                return (true, "Correct Login")
            }
            else {
                return (false, "Wrong password!")
            }
        }
        
    }
    
    class func QueryAccount(email: String) -> Tutor? {
        let query = "SELECT * FROM Tutor WHERE email='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let msg = resquery.1
        if (msg.status) {
            let row = resquery.0.first
            if (row == nil){
                return nil
            }
            else {
                let tutor = Tutor.ParseResult(row!)
                return tutor
            }
        }
        
    }
    
    class func CreateAccount(tutor: Tutor) -> StatusMsg {
        let query = "INSERT INTO Tutor (FSUEmail, FirstName, LastName, Phone, Rating, NumberVotes, PricePerHour, Bio) VALUES ('" + tutor.email + "','" + tutor.firstname + "','" + tutor.lastname + "'," + tutor.phone + "," + tutor.rating + "," + tutor.numbervotes + "," + tutor.priceperhour + ",'" + tutor.bio + "');"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func ChangePhoto(tutor: Tutor) -> StatusMsg {
        if (tutor.photo == nil){
            return Tutor.RemovePhoto(tutor)
        }
        else{
            let query = "UPDATE Tutor SET Photo='" + SQLInteract.imageTobase64(image: tutor.photo!) + "' WHERE FSUEmail='" + tutor.email + "';"
            return SQLInteract.ExecuteModification(query: query)
        }
        
    }
    
    
    class func RemovePhoto(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE Tutor SET Photo=NULL WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func EditAccount(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE Tutor SET FirstName='" + tutor.firstname + "', LastName='" + tutor.lastname + "', Phone=" + tutor.phone + ", Rating=" + tutor.rating + ", NumberVotes=" + tutor.numbervotes + ", PricePerHour=" + tutor.priceperhour + ", Bio='" + tutor.bio + "'  WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func DeleteAccount(tutor: Tutor) -> StatusMsg  {
        let query = "DELETE FROM Tutor WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func SignIn(FSUEmail: String, Password: String) -> StatusMsg {
        let query = "INSERT INTO User VALUES ('" + FSUEmail + "','" + Password + "');"
        return SQLInteract.ExecuteModification(query: query)
    }
    
}

