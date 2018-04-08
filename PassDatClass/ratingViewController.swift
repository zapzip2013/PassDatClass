//
//  ratingViewController.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 4/6/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by Jose Carlos & Alexander Holmstock & Daniel Gibney */

import UIKit

class ratingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    rating.rating = Int(passedValue.rating)
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var rating: ratings!
    var passedValue:Tutor!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
    }

    @IBAction func exit(_ sender: Any) {
        if(passedValue.numbervotes == 0){
            passedValue.rating = Float(rating.rating)
        }else{
            passedValue.rating = (Float(passedValue.numbervotes) * passedValue.rating + Float(rating.rating)) / Float(passedValue.numbervotes+1)
        }
    passedValue.numbervotes += 1
    Tutor.EditAccount(tutor: passedValue!)
    dismiss(animated: true, completion: nil)
    }
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
