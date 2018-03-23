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
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        name.text = passedValue.name
        picture.image = passedValue.photo
    }
    var passedValue:Tutor!

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
}
