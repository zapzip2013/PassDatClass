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
        loadsampletutors()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
        
        let tutor = tutors[indexPath.row]
        // Configure the cell...
        cell.namelabel.text = tutor.name
        cell.profileimage.image = tutor.photo
        cell.rating.rating = tutor.rating
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
        let photo1 = UIImage(named: "tutor1")
        let photo2 = UIImage(named: "tutor2")
        let photo3 = UIImage(named: "tutor3")
        guard let tutor1 = Tutor(phone: 6, email: "1", name: "adam", rating: 2, photo: photo1, verified: true, bio: "String") else {
            fatalError("Unable to instantiate tutor1")
        }
        guard let tutor2 = Tutor(phone: 4, email: "1", name: "amanda", rating: 3, photo: photo2, verified: true, bio: "Stringelse") else {
            fatalError("Unable to instantiate tutor2")
        }
        guard let tutor3 = Tutor(phone: 5, email: "1", name: "anakin", rating: 1, photo: photo3, verified: true, bio: "String") else {
            fatalError("Unable to instantiate tutor3")
        }
        tutors += [tutor1, tutor2, tutor3]
    }}
