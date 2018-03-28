//
//  TutorTableViewController.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 2/23/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

class TutorTableViewController: UITableViewController {

    var tutors = [Tutor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loads sample tutors
        passedclassname = searchname
        passedclassnum = searchnum
        loadsampletutors()
        let bckimg = UIImageView(image: UIImage(named: "624878906.jpg")!)
        bckimg.contentMode = .scaleAspectFill
        self.tableView.backgroundView = bckimg
        
    }


    public var passedclassnum:String!
    public var passedclassname:String!
    
    @IBOutlet weak var testlabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    var valueToPass:Tutor!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "modalseg"){
            var viewController = segue.destination as! tutormodal
            
            let indexPath = tableView.indexPathForSelectedRow;
            let currentCell = tableView.cellForRow(at: indexPath!)
            let tutor = tutors[(indexPath?.row)!]
            print("hello \(tutor.name) \n")
            valueToPass = tutor//[(indexPath?.row)!]
            viewController.passedValue = valueToPass
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tutors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TutorViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TutorTableViewCell else {
            fatalError("the dequeued cell is not an instance of tutorTableViewCell")
        }
        let nophoto = UIImage(named: "download-1.jpg")
        let tutor = tutors[indexPath.row]
        // Configure the cell...
        cell.namelabel.text = tutor.name
        if(tutor.photo == nil){
            tutor.photo = nophoto
        }
        cell.profileimage.image = tutor.photo
        cell.rating.rating = Int(tutor.rating)
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    private func loadsampletutors(){
        /*let photo1 = UIImage(named: "tutor1")
        let photo2 = UIImage(named: "tutor2")
        let photo3 = UIImage(named: "tutor3")
        let tutor1 = Tutor(phone: 6, email: "1", name: "adam", lastname: "ok", rating: 2, numbervotes: 110, photo: photo1, price: 3.2, verified: true, bio: "String")
        let tutor2 = Tutor(phone: 4, email: "1", name: "amanda", lastname: "nop", rating: 3, numbervotes: 2200, photo: photo2, price: 11.1, verified: true, bio: "Stringelse")
        let tutor3 = Tutor(phone: 5, email: "1", name: "anakin", lastname: "aja", rating: 1, numbervotes: 23, photo: photo3, price: 22222.2, verified: true, bio: "String")
       // let search = Search(prefix: <#T##String#>, number: <#T##Int#>, ver: <#T##Bool#>)
        tutors += [tutor1, tutor2, tutor3] //Tutor.QueryAccount(email: "kljhklhg")!]*/
        let test = Search(prefix: passedclassname, number: Int(passedclassnum)!, ver: true)
        tutors += test.ExecuteQuery()
        if (tutors.count == 0){
            testlabel.isHidden = false
        }
        
    }
    
}
