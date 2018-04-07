//
//  tutormodal.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 3/13/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

class tutormodal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = true;
        name.text = passedValue.name
        if (passedValue.photo != nil){
            picture.image = passedValue.photo
            picture.layer.cornerRadius = picture.frame.size.width / 2.0
            picture.clipsToBounds = true
        }

    }
    var passedValue:Tutor!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ratingseg"){
            let viewController = segue.destination as! ratingViewController
            
            var valueToPass = passedValue//[(indexPath?.row)!]
            viewController.passedValue = valueToPass
        }
    }
    
    @IBAction func back(_ sender: Any) {
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
            dismiss(animated: true, completion: nil)
        }
    }
}

