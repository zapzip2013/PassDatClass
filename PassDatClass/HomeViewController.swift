//
//  HomeViewController.swift
//  
//
//  Created by Bradley Close on 2018-03-12.
//  Copyright © 2018 Bradley Close. All rights reserved.
//
/* Implemented by Bradley Close */

import Foundation
import UIKit


class HomeViewController:UIViewController {
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        super.viewDidLoad()
        
    }
    
    @IBAction func handleLogout(_ sender:Any) {
        
    }
}
