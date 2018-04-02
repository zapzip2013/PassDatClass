//
//  EditViewController.swift
//  PassDatClass
//
//  Created by Tallafoc on 4/1/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

var referenceedit : EditViewController? = nil

class EditViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addclassField: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var referenceButton: UIView!
    
    var continueButton:RoundedWhiteButton!
    var imagePicker:UIImagePickerController!
    
    @IBAction func addClass(_ sender: Any) {
        let text = addclassField.text
        tutor?.AddCourse(course: text!)
        referencecourses?.chargeList(list: (tutor?.listcourses)!)
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photo.contentMode = .scaleAspectFit
            photo.image = pickedImage.resize(withWidth: 500.0)
        }
        
        
        /*
         
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         
         */
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    func loadValues(){
        nameField.text = tutor?.firstname
        lastnameField.text = tutor?.lastname
        priceField.text = String(describing: tutor!.priceperhour)
        phoneField.text = String(describing: tutor!.phone)
        referencecourses?.chargeList(list: (tutor?.listcourses)!)
        photo.image = tutor?.photo
    }
    
    
    var tutor : Tutor?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        referenceedit = self
        // Do any additional setup after loading the view.
        loadValues()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Edit", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: referenceButton.center.y + continueButton.frame.height)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        continueButton.alpha = 0.5
        internalView.addSubview(continueButton)
    }
    
    func reloadValues() {
        tutor?.photo = photo.image
        tutor?.firstname = nameField.text!
        tutor?.lastname = lastnameField.text!
        tutor?.phone = Int(phoneField.text!)!
        tutor?.priceperhour = Float(priceField.text!)!
    }
    
    @objc func handleEdit(){
        reloadValues()
        let result = Tutor.EditAccount(tutor: tutor!)
        let result2 = Tutor.ChangePhoto(tutor: tutor!)
        if (result.status && result2.status) {
            continueButton.setTitle("Updated!", for: .normal)
        }
        else {
            continueButton.setTitle("Failed", for: .normal)
        }
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
