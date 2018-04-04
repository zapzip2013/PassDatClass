//
//  User.swift
//  ClassesManager
//
//  Created by Jose Carlos on 2/8/18.
//  Copyright © 2018 PassDatClass. All rights reserved.
//  User-defined functions for User profiles
/*  Implimented by Jose Carlos & Jordan Mussman */

import Foundation
import CryptoSwift

public class User {
    
    class func LogIn(email: String, password: String) -> StatusMsg {    /* Login by matching FSUEmail and Password */
        let query = "SELECT * FROM User WHERE FSUEmail='" + email + "';"
        let resquery = SQLInteract.ExecuteSelect(query: query)
        let msg = resquery.1
        if msg.status == false {
            return msg
        }
        else if (resquery.0.isEmpty){
            return (false, "There's no such username registered!") /* Failed username */
        }
        else {
            let DBpass = resquery.0.first!["Password"] as! String
            let cryptpass = AddSaltPepper(pass: password) /* Encrypt user-inputted password */
            if (cryptpass == DBpass){
                return (true, "Correct Login")
            }
            else {
                return (false, "Wrong password!")   /* Failed password check */
            }
        }
    }

/* SignIn() inserts the current user entry from our user/profile table */
    class func SignIn(FSUEmail: String, Password: String) -> StatusMsg {
        let result = Tutor.QueryAccount(email: FSUEmail)
        if (result != nil){
            return (false, "The email is already registered on the system")
        }
        let query = "INSERT INTO User VALUES ('" + FSUEmail + "','" + AddSaltPepper(pass: Password) + "');"
        return SQLInteract.ExecuteModification(query: query)
    }
    
/* SignOut deletes the current user entry from our user/profile table */
    class func SignOut(tutor: Tutor) -> StatusMsg {
        let query = "DELETE FROM User WHERE FSUEmail='" + tutor.email + "';"
        return SQLInteract.ExecuteModification(query: query)
    }
    
/* SHA-256 encrypt passwords. WE DO NOT STORE PASSWORDS */
    class func encrypt(_ pass: String) -> String {
        let bytes = pass.bytes
        let hashed = bytes.sha256().toHexString()
        return hashed
    }
    
/* Adding Salt & Pepper to password */
    class func AddSaltPepper(pass: String) -> String {
        let salt = "DDSADSA;"
        let pepper = "435432!"
        let result = salt + pass + pepper;
        let cryptresult = encrypt(result)
        return cryptresult
    }
    
}

