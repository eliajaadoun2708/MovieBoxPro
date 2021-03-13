//
//  LoginViewController.swift
//  MovieBoxPro
//
//  Created by elia jadoun on 02/03/2021.
//

import UIKit
import FirebaseAuth
import PKHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextField.text, isEmailValid,
              let password = passwordTextField.text, isPasswordValid else {
            return
        }
        //start the auth process:
        sender.isEnabled = false //can't click Register twice
        showProgress(title: "Please Wait")
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (result, err) in
            
            if let err = err{
                self?.showError(title: err.localizedDescription) //"אנא נסה שוב מאוחר יותר"
                sender.isEnabled = true
                return
            }
            
            self?.showSuccess(title: "Done!")
            Router.shared.determineRootViewController() //change a line in the router
        }
    }
}
