//
//  SignUpViewController.swift
//
//
//  Created by Bradley Close on 3/21/18.
//

/* Implemented by Bradley Close and Jose Carlos Torres */

import Foundation
import UIKit
class SignUpViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var classcodeField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var referenceButton: UILabel!
    @IBOutlet weak var classnumber: UITextField!
    
    var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        
        let arrayField = [nameField, lastnameField,emailField,phoneField,passwordField,priceField,classnumber,classcodeField]
        for field in arrayField{
            field?.delegate = self
            field?.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: referenceButton.center.y + continueButton.frame.height)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        continueButton.alpha = 0.5
        internalView.addSubview(continueButton)
        // setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        // continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    func valid_name() -> Bool{
        let name = nameField.text
        let lastname = lastnameField.text
        let Classcode = classcodeField.text?.uppercased()
        let Classnum = classnumber.text
        let phone = phoneField.text
        let price = priceField.text
        let email = emailField.text
        if(lastnameField.text == "" || nameField.text == "" || phoneField.text == "" || emailField.text == "" || passwordField.text == ""){
            alert(warning: "Must enter all required fields")
            return false
        }
        if(!nameregex.evaluate(with: name) || (!nameregex.evaluate(with: lastname))){
            alert(warning: "Name must be characters,dashes or spaces")
            return false
        }
        
        if (Classcode != "" || Classnum != ""){
            if(!clasregex.evaluate(with: Classcode)){
                alert(warning: "Class code must be 3 letters long")
                return false
            }
            if(!numregex.evaluate(with: Classnum)){
                alert(warning: "Class number must be 4 numbers long")
                return false
            }
        }
        if(!phoneregex.evaluate(with: phone)){
            alert(warning: "US Phone number must be 10 digits long")
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if(!emailTest.evaluate(with: email!)){
            alert(warning: "Email must be apropiate format")
            return false
        }

        let floatTest = priceregex
        if(price == "" && (Classcode != "" || Classnum != "")){
            alert(warning: "Price must be in format $$.¢¢")
            return false
        }
        
        if(price != "" && !floatTest.evaluate(with: price!)){
            alert(warning: "Price must be in format $$.¢¢")
            return false
        }
        
        
        
        return true
    }
    func alert(warning: String){
        warningLabel.text = warning
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoedit"){
            let viewController = segue.destination as! EditViewController
            let tutor = Tutor.QueryAccount(email: emailField.text!)
            viewController.tutor = tutor
        }
    }
    
    func gotoEdit(){
        loggedin = emailField.text!
        
        let name = emailField.text!
        let tutor = Tutor.QueryAccount(email: name)
        if (tutor?.bio != ""){
            let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
            vc.tutor = tutor
            present(vc, animated: true, completion: nil)
        }
        else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func handleSignIn() {
        if(valid_name()){
            if (priceField.text == ""){
                priceField.text = "0.0"
            }
            if (classcodeField.text == ""){
                classcodeField.text = ""
                classnumber.text = ""
            }
            
        let newtutor = Tutor(phone: Int(phoneField.text!)!, email: emailField.text!, name: nameField.text!, lastname: lastnameField.text!, rating: 0, numbervotes: 0, photo: profileImageView.image, price: Float(priceField.text!)!, verified: false, bio: (classcodeField.text!.uppercased() + classnumber.text!))
        let user = User.SignIn(FSUEmail: emailField.text!, Password: passwordField.text!)
        if (user.status){
            let result = Tutor.CreateAccount(tutor: newtutor)
            if (result.status) {
                let result2 = Tutor.ChangePhoto(tutor: newtutor)
                if (result2.status) {
                    warningLabel.text = "Created successfully"
                    gotoEdit()
                }
                else {
                    warningLabel.text = "Error :\(result.msg)"
                }
            }
            else {
                warningLabel.text = "Error : \(result.msg)"
            }
        }
        else {
            warningLabel.text = "Error: \(user.msg)"
        }
    }
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.image = pickedImage.resize(withWidth: 500.0)
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true
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
    
    @objc func textFieldChanged(_ target:UITextField) {
        let formFilled = !(lastnameField.text == "" || nameField.text == "" || phoneField.text == "" || emailField.text == "" || passwordField.text == "")
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
}

extension UIImage {
    
    func resize(withWidth newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

