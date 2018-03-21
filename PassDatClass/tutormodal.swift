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
        name.text = passedValue.firstname
        lastname.text = passedValue.lastname
        picture.image = passedValue.photo
    }
    var passedValue:Tutor!

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var lastname: UILabel!
    
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

}
