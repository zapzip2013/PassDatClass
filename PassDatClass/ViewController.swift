//
//  ViewController.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 2/7/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by: Alexander Holmstock */

import UIKit

var loggedin : String?


class ViewController: UIViewController {
    
    @IBAction func logOut(_ sender: Any) {
        loggedin = nil
    }
    
    @IBOutlet weak var logOutButton: RoundedWhiteButton!
    @IBOutlet weak var HamburgerMenu: UIView!
    @IBOutlet weak var FAQ: UIScrollView!
    
    @IBAction func wantToHelp(_ sender: Any) {
        if let email = loggedin {
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
            vc.tutor = Tutor.QueryAccount(email: email)
            present(vc, animated: true, completion: nil)
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func hamburgerButtonIsPressed(_ sender: Any) {
        if (HamburgerMenu.isHidden){
            HamburgerMenu.isHidden = false
        }
        else {
            HamburgerMenu.isHidden = true
        }
    }
    
    @IBAction func faqButtonIsPressed(_ sender: Any) {
        if (FAQ.isHidden){
            FAQ.isHidden = false
        }
        else {
            FAQ.isHidden = true
        }
    }
    
    @IBAction func xFAQButtonIsPressed(_ sender: Any) {
        FAQ.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (loggedin == nil && logOutButton != nil){
            logOutButton.isHidden = true
        }
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

