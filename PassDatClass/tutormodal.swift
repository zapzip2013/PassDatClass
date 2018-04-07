//
//  tutormodal.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 3/13/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

class tutormodal: UIViewController {

    @IBOutlet weak var price: UILabel!
    var result : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = true;
        name.text = passedValue.name
        price.text = "$" + String(passedValue.priceperhour)
        if (passedValue.photo != nil){
            picture.image = passedValue.photo
            picture.layer.cornerRadius = picture.frame.size.width / 2.0
            picture.clipsToBounds = true
        }
        if (loggedin == nil){
            tutorRating.isHidden = true
            notloggedlabel.text = "Only logged users can rate"
        }
        else {
            let resultcheck = tutorCheck()
            if (resultcheck.0){
                result = resultcheck.1
                tutorRating.rating = result!
            }
        }

    }
    var passedValue:Tutor!
    @IBOutlet weak var notloggedlabel: UILabel!
    
    func tutorCheck() -> (Bool, Int) {
        if (loggedin != nil){
            let query = "SELECT * FROM tutorrated WHERE Tutor='\(passedValue.email)' AND Ratedby='\(loggedin!)';"
            let result = SQLInteract.ExecuteSelect(query: query).0
            if let first = result.first {
                let numberstring = first["Rating"] as! String
                let number = Int(numberstring)!
                return (true,number)
            }
            else {
                return (false,0)
            }
        }
        else {
            return (false,0)
        }
    }
    
    func uploadVote() {
        let query2 : String = "INSERT INTO tutorrated VALUES ('\(passedValue.email)','\(loggedin!)',\(tutorRating.rating));"
        let _ = SQLInteract.ExecuteModification(query: query2)
    }
    
    func editVote() {
        let query2 : String = "UPDATE tutorrated SET Rating=\(result!) WHERE Tutor='\(passedValue.email)' AND Ratedby='\(loggedin!)';"
        let _ = SQLInteract.ExecuteModification(query: query2)
    }
    
    func updateCell(){
        if let i = referencetable?.tutors.index(where: { $0.email == passedValue.email }) {
            referencetable?.tutors[i].rating = passedValue.rating
        }
        referencetable?.tableView.reloadData()
    }
    
    func changeRating(){
        if (tutorRating.touched){
            if (result != nil){
                if (passedValue.numbervotes == 1){
                    passedValue.rating = 0
                }
                else {
                    passedValue.rating = ((passedValue.rating * Float(passedValue.numbervotes)) - Float(result!))/(Float(passedValue.numbervotes - 1))
                }
                result = tutorRating.rating
                passedValue.numbervotes -= 1
                editVote()
            }
            else {
                uploadVote()
            }
            passedValue.rating = ((passedValue.rating * Float(passedValue.numbervotes)) + Float(tutorRating.rating))/(Float(passedValue.numbervotes + 1))
            passedValue.numbervotes += 1
            _ = Tutor.EditAccount(tutor: passedValue)
            updateCell()
        }
    }

    
    
    @IBAction func back(_ sender: Any) {
        changeRating()
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    @IBAction func Email(_ sender: Any) {
        let email = passedValue.email
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func calling(_ sender: Any) {
        let phone = passedValue.phone
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @IBOutlet weak var tutormodalpop: UIView!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != tutormodalpop {
            //calculating new rating and sending to DB before dismissing modal
            changeRating()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var tutorRating: ratings!
    
    
}

