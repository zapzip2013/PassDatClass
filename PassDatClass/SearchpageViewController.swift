//
//  SearchpageViewController.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 3/19/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

var searchnum : String = ""
var searchname : String = ""

class SearchpageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var course_num: UITextField!
    
    @IBOutlet weak var hid: UIButton!
    @IBOutlet weak var course_chars: UITextField!
    @IBOutlet weak var warningmsg: UILabel!
    @IBAction func warningexit(_ sender: Any) {
        warningmsg.isHidden = true
        hid.isHidden = true
    }
    func alert(){
        hid.isHidden = false
        warningmsg.isHidden = false
    }
    
    var valueToPass:String!
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "searchresultseque"){
        let num = course_num.text
        let char = course_chars.text
        if(num?.count != 4){
            alert()
            return false
        }
        if(char?.count != 3){
            alert()
            return false
        }
        let Digits = CharacterSet.decimalDigits
            for index in num!.unicodeScalars {
            if(!(Digits.contains(index))){
                alert()
                return false
            }
        }
        }
        return true
    }
    @IBOutlet weak var errorview: UILabel!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != errorview {
            errorview.isHidden = true
            hid.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "searchresultseque"){
            let viewController = segue.destination as! TutorViewController
          
        searchnum = course_num.text!
        searchname = course_chars.text!
            //TODO: Check that user has int instead of string since string will cause failure
            viewController.passedclassnum = searchnum
            viewController.passedclassname = searchname.uppercased()
        
        /*let controller: TutorTableViewController = storyboard!.instantiateViewController(withIdentifier: "tabletutor") as! TutorTableViewController
        controller.passedclassname = num
        controller.passedclassnum = char*/
            
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
