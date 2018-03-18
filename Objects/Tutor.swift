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
import CryptoSwift

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
        let priceperhour = row["pricePerHour"] as! String
        let numbervotes = row["numberVotes"] as! String
        let phone = row["phoneNumber"] as! String
        let bio = row["bio"] as! String
        let rating = row["rating"] as! String
        let fsuver = row["FSUVerified"] as! String
        var fsuverified : Bool
        if (fsuver == "1"){
            fsuverified = true
        }
        else {
            fsuverified = false
        }
        let email = row["FSUEmail"] as! String
        let photo = SQLInteract.base64ToImage(base64: row["photo"] as? String)
        let ret = Tutor(phone: Int(phone)!, email: email, name: firstname, lastname: lastname, rating: Float(rating)!, numbervotes: Int(numbervotes)!, photo: photo, price: Float(priceperhour)!, verified: fsuverified, bio: bio)
        return ret
    }
    
    class func encrypt(_ pass: String) -> String {
        let bytes = pass.bytes
        let hashed = bytes.sha256().toHexString()
        return hashed
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
        let query = "SELECT * FROM Tutor WHERE FSUEmail='" + email + "';"
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
        else {
            return nil
        }
    }
    
    class func CreateAccount(tutor: Tutor) -> StatusMsg {
        let query = "INSERT INTO Tutor (FSUEmail, firstName, lastName, phoneNumber, rating, numberVotes, pricePerHour, bio) VALUES ('\(tutor.email)','\(tutor.firstname)','\(tutor.lastname)',\(tutor.phone),\(tutor.rating),\(tutor.numbervotes),\(tutor.priceperhour),'\(tutor.bio)');"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func ChangePhoto(tutor: Tutor) -> StatusMsg {
        if (tutor.photo == nil){
            return Tutor.RemovePhoto(tutor: tutor)
        }
        else{
            let query = "UPDATE Tutor SET photo='" + SQLInteract.imageTobase64(image: tutor.photo!) + "' WHERE FSUEmail='" + tutor.email + "';"
            return SQLInteract.ExecuteModification(query: query)
        }
        
    }
    
    
    class func RemovePhoto(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE Tutor SET photo=NULL WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func EditAccount(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE Tutor SET firstName='\(tutor.firstname)', lastName='\(tutor.lastname)', phoneNumber=\(tutor.phone), rating=\(tutor.rating), numberVotes=\(tutor.numbervotes), pricePerHour=\(tutor.priceperhour), bio='\(tutor.bio)'  WHERE FSUEmail='\(tutor.email)';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func DeleteAccount(tutor: Tutor) -> StatusMsg  {
        let query = "DELETE FROM Tutor WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func SignIn(FSUEmail: String, Password: String) -> StatusMsg {
        let query = "INSERT INTO User VALUES ('" + FSUEmail + "','" + AddSaltPepper(pass: Password) + "');"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    class func SignOut(tutor: Tutor) -> StatusMsg {
        let query = "DELETE FROM User WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
}

