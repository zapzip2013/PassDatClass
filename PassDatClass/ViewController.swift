//
//  ViewController.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 2/7/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by: Alexander Holmstock */

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var HamburgerMenu: UIView!
    @IBOutlet weak var FAQ: UIScrollView!
    
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
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

