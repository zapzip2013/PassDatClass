//
//  Tutor.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//

/* Implemented by Jose Carlos & Jordan Mussman */


import Foundation
import UIKit
import CryptoSwift



public class Tutor : User {
    internal static var tablename = "tutor"
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
    public var name : String {  /* Swift allows easy get methods */
        get{
            return lastname + "," + firstname
        }
    }
    
    public var listcourses : [String.SubSequence]{
        get{
            return bio.split(separator: ",")
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
        if (fsuver == "1"){ /* Set true/1 for FSUVerification, else false/0 */
            fsuverified = true
        }
        else {
            fsuverified = false
        }
        let email = row["FSUEmail"] as! String
        let photo = SQLInteract.base64ToImage(base64: row["photo"] as? String)  /* Encode to base64 */
        let ret = Tutor(phone: Int(phone)!, email: email, name: firstname, lastname: lastname, rating: Float(rating)!, numbervotes: Int(numbervotes)!, photo: photo, price: Float(priceperhour)!, verified: fsuverified, bio: bio) /* Init tutor object with current call's DB data, then return that */
        return ret
    }
    
/* Using ExecuteSelect() helper function to send query json object to db */
    class func QueryAccount(email: String) -> Tutor? {
        let query = "SELECT * FROM \(tablename) WHERE FSUEmail='" + email + "';"
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
    
/* Creates a new tutor account in db */
    class func CreateAccount(tutor: Tutor) -> StatusMsg {
        let query = "INSERT INTO \(tablename) (FSUEmail, firstName, lastName, phoneNumber, rating, numberVotes, pricePerHour, bio) VALUES ('\(tutor.email)','\(tutor.firstname)','\(tutor.lastname)',\(tutor.phone),\(tutor.rating),\(tutor.numbervotes),\(tutor.priceperhour),'\(tutor.bio)');"
        return SQLInteract.ExecuteModification(query: query)
    }

/* Creates a new tutor account in db */
    class func ChangePhoto(tutor: Tutor) -> StatusMsg {
        if (tutor.photo == nil){
            return Tutor.RemovePhoto(tutor: tutor)
        }
        else{
            SQLInteract.uploadPhoto(tutor: tutor)
            let query = "UPDATE \(tablename) SET photo='" + SQLInteract.imageTobase64(image: tutor.photo!) + "' WHERE FSUEmail='" + tutor.email + "';"
            return SQLInteract.ExecuteModification(query: query)
        }
    }
    
 /* Helper function for ChangePhoto() */
    class func RemovePhoto(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE \(tablename) SET photo=NULL WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
    /* Add a course to a Tutor */
    func AddCourse(course: String) {
        self.bio.append(",\(course)")
    }
    
    /* Remove a course from a Tutor */
    func RemoveCourse(course: String) {
        let list = self.listcourses
        let mutatedlist = list.filter{$0 != course}
        self.bio = mutatedlist.joined(separator: ",")
    }
  
/* Extends all the changes made to a Tutor to the DB */
    class func EditAccount(tutor: Tutor) -> StatusMsg {
        let query = "UPDATE \(tablename) SET firstName='\(tutor.firstname)', lastName='\(tutor.lastname)', phoneNumber=\(tutor.phone), rating=\(tutor.rating), numberVotes=\(tutor.numbervotes), pricePerHour=\(tutor.priceperhour), bio='\(tutor.bio)'  WHERE FSUEmail='\(tutor.email)';"
        return SQLInteract.ExecuteModification(query: query)
    }

/* Deletes a tutor's information from the db */
    class func DeleteAccount(tutor: Tutor) -> StatusMsg  {
        let query = "DELETE FROM \(tablename) WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
}
