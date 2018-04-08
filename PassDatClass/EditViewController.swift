//
//  EditViewController.swift
//  PassDatClass
//
//  Created by Tallafoc on 4/1/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//
/* Implemented by Jose Carlos & Alexander Holmstock & Daniel Gibney & Bradley Close & Jordan Mussman & Tyree Lewis */

import UIKit

var referenceedit : EditViewController? = nil


let nameregex = NSPredicate(format:"SELF MATCHES %@", "([A-Za-z- ])+")
let phoneregex = NSPredicate(format:"SELF MATCHES %@", "([2-9]{1})([0-9]{9})")
let priceregex = NSPredicate(format: "SELF MATCHES %@", "([0-9])+.([0-9]){1,2}")
let clasregex = NSPredicate(format:"SELF MATCHES %@", "[A-Z]{3}")
let numregex = NSPredicate(format:"SELF MATCHES %@", "[1-9][0-9]{3}")

class EditViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addclassField: UITextField!
    @IBOutlet weak var addnumberField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var referenceButton: UIView!
    
    var continueButton:RoundedWhiteButton!
    var imagePicker:UIImagePickerController!
    
    @IBAction func addClass(_ sender: Any) {
        let clas = addclassField.text!.uppercased()
        let num = addnumberField.text!
        if (!clasregex.evaluate(with: clas)){
            alert(warning: "Class must be 3 letters long")
            return
        }
        if (!numregex.evaluate(with: num)){
            alert(warning: "Number must be 4 number long")
            return
        }
        let text = clas + num
        continueButton.setTitle("Edit", for: .normal)
        addclassField.text = ""
        addnumberField.text = ""
        tutor?.AddCourse(course: text)
        referencecourses?.chargeList(list: (tutor?.listcourses)!)
    }
    
    func alert(warning: String){
        warningLabel.text = warning
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            photo.image = pickedImage.resize(withWidth: 500.0)
            continueButton.setTitle("Edit", for: .normal)
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
    
    @objc func textFieldChanged(_ target:UITextField) {
        let formFilled = !(lastnameField.text == "" || nameField.text == "" || phoneField.text == "" || priceField.text == "")
        continueButton.setTitle("Edit", for: .normal)
        setContinueButton(enabled: formFilled)
    }
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    
    var tutor : Tutor?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        let arrayField = [nameField,lastnameField,phoneField,priceField]
        for field in arrayField{
            field?.delegate = self
            field?.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        referenceedit = self
        // Do any additional setup after loading the view.
        loadValues()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = photo.frame.size.width / 2
        photo.clipsToBounds = true
        
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Edit", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: referenceButton.center.y + continueButton.frame.height)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        internalView.addSubview(continueButton)
    }
    
    func reloadValues() -> Bool {
        tutor?.photo = photo.image
        if (!nameregex.evaluate(with: nameField.text!)){
            alert(warning: "Only valid characters on name")
            return false
        }
        if (!nameregex.evaluate(with: lastnameField.text!)){
            alert(warning: "Only valid characters on last name")
            return false
        }
        if (!phoneregex.evaluate(with: phoneField.text!)){
            alert(warning: "Only valid US numbers")
            return false
        }
        if (!priceregex.evaluate(with: priceField.text!)){
            alert(warning: "Price must be in format $$.¢¢")
            return false
        }
        
        tutor?.firstname = nameField.text!
        tutor?.lastname = lastnameField.text!
        tutor?.phone = Int(phoneField.text!)!
        tutor?.priceperhour = Float(priceField.text!)!
        return true
    }
    
    @objc func handleEdit(){
        if (reloadValues()) {
        alert(warning: "")
        let result = Tutor.EditAccount(tutor: tutor!)
        let result2 = Tutor.ChangePhoto(tutor: tutor!)
        if (result.status && result2.status) {
            continueButton.setTitle("Updated!", for: .normal)
        }
        else {
            continueButton.setTitle("Failed", for: .normal)
        }
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
