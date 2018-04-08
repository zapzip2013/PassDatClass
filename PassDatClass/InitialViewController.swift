//
//  InitialViewController.swift
//  PassDatClass
//
//  Created by Bradley Close on 3/21/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by Bradley Close */

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "toMenuScreen", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}
