//
//  RegisterVC.swift
//  eating in
//
//  Created by Imogen Kraak on 21/01/2020.
//  Copyright © 2020 Imogen Kraak. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passCheck: UIImageView!
    @IBOutlet weak var passConfirmCheck: UIImageView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        passText.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        confirmPassText.addTarget(self, action: #selector(textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        print("Typing in textfields")
    }
    
    @objc func textFieldDidChange( textfield: UITextField) {
        guard let passwordText = passText.text else { return }
        
        if textfield == confirmPassText {
            passCheck.isHidden = false
            passConfirmCheck.isHidden = false
        } else {
            if passwordText.isEmpty {
                passCheck.isHidden = true
                passConfirmCheck.isHidden = true
                confirmPassText.text = ""
            }
        }
        if passText.text == confirmPassText.text {
            passCheck.image = UIImage(named: AppImages.Tick)
            passConfirmCheck.image = UIImage(named: AppImages.Tick)
        } else {
            passCheck.image = UIImage(named: AppImages.redTick)
            passConfirmCheck.image = UIImage(named: AppImages.redTick)
        }
        }
    
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailText.text, email.isNotEmpty ,
            let username = usernameText.text, username.isNotEmpty ,
            let password = passText.text, password.isNotEmpty else {
        simpleAlert(title: "Error", msg: "Please fill out all fields")
                return
        }
        guard let confirmPass = confirmPassText.text, confirmPass == password else {
            simpleAlert(title: "Error", msg: "Passwords do not match")
            return
        }
        
    
        
        guard let authUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, link: password)
        
        authUser.link(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error)
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    

  

}
