//
//  TutorViewController.swift
//  PassDatClass
//
//  Created by Jose Carlos Torres Quiles on 3/28/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

class TutorViewController: UIViewController {
    
    @IBOutlet weak var sortView: UIView!
    var passedclassnum:String!
    var passedclassname:String!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var blocktableview: UIView!
    @IBAction func sort(_ sender: Any) {
        sortView.isHidden = false
        blocktableview.isHidden = false
    }
    
    
    
    func changeSort(sort: Sorting) { referencetable?.changeOrder(sort: sort)
        sortView.isHidden = true
        blocktableview.isHidden = true
    }
    
    @IBAction func firsNameSort(_ sender: Any) {
        changeSort(sort: .alph)
    }
    
    @IBAction func inverseLastNameSort(_ sender: Any) {
       changeSort(sort: .inversealph)
    }
    
    @IBAction func lastNameSort(_ sender: Any) {
        changeSort(sort: .lastnamealph)
    }
    
    @IBAction func ratingSort(_ sender: Any) {
        changeSort(sort: .rating)
    }
    
    @IBAction func photoSort(_ sender: Any) {
        changeSort(sort: .firstwithphoto)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != sortView {
            sortView.isHidden = true
            blocktableview.isHidden = true
        }
        //rough implementation to close sort if touch isnt on sort
    }
    
    
    
    @IBAction func showSort(_ sender: Any) {
        sortView.isHidden = false
        blocktableview.isHidden = false
    }
    @IBOutlet weak var navbar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = passedclassnum
        num.text = passedclassname
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
      
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
