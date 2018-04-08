//
//  LoginViewController.swift
//  
//
//  Created by Bradley Close on 2018-03-12.
//  Copyright © 2018 Bradley Close. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    var continueButton:RoundedWhiteButton!
    var continueButton2:RoundedWhiteButton!

    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Log in", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.size.height/2)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        continueButton.alpha = 0.5
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        continueButton2 = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton2.setTitleColor(secondaryColor, for: .normal)
        continueButton2.setTitle("Sign up", for: .normal)
        continueButton2.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton2.center = CGPoint(x: view.center.x, y: view.frame.size.height - 50)
        continueButton2.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton2.defaultColor = UIColor.white
        continueButton2.addTarget(self, action: #selector(gotoSignUp), for: .touchUpInside)
        view.addSubview(continueButton2)
        
        
        /*activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)*/
        
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @objc func gotoSignUp(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUp")
        present(vc!, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailField.text
        let password = passwordField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        continueButton.setTitle("Log in", for: .normal)
        setContinueButton(enabled: formFilled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            handleSignIn()
            break
        default:
            break
        }
        return true
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoedit"){
            let viewController = segue.destination as! EditViewController
            let tutor = Tutor.QueryAccount(email: emailr!)
            viewController.tutor = tutor
        }
        if (segue.identifier == "gotomainfromlogin"){
            // DO NOTHING
        }
    }
    
    var emailr : String?
    
    @objc func handleSignIn() {
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        emailr = email
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        let result = User.LogIn(email: email, password: pass)
        if (result.status) {
            activityView.stopAnimating()
            continueButton.setTitle("Logged IN!", for: .normal)
            loggedin = email
            let tutor = Tutor.QueryAccount(email: email)
            if tutor?.bio == "" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                present(vc, animated: true, completion: nil)
            }
            else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
                vc.tutor = tutor
                present(vc, animated: true, completion: nil)
            }
            
        }
        else {
            activityView.stopAnimating()
            continueButton.setTitle("FAILURE", for: .normal)
        }
       
    }
}
