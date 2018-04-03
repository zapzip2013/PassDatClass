//
//  FAQview.swift
//  PassDatClass
//
//  Created by Daniel Gibney and Tyree Lewis on 3/19/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

class FAQview: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exit(_ sender: Any) {
    dismiss(animated: true, completion: nil)

    }
    
    //**** Addition by Tyree Lewis ****//
    @IBOutlet weak var internalView: UIView!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch: UITouch? = touches.first
        if touch?.view != internalView{
            dismiss(animated: true, completion: nil)
        }
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
