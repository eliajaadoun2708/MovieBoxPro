//
//  SignUpViewController.swift
//  MovieBoxPro
//
//  Created by elia jadoun on 02/03/2021.
//

import UIKit
import FirebaseAuth
import PKHUD

class RegisterViewController: UIViewController {
    
    //לא לשנות הפעם את השמות - נסו להעתיק את השמות האלה לכל מקום - נשתמש בשמות האלה בדיוק בעוד כמה מקומות
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    
    @IBAction func register(_ sender: UIButton) {
        
        guard let email = emailTextField.text, isEmailValid,
              let password = passwordTextField.text, isPasswordValid,
              var nickName = nickNameTextField.text
              else {
              return
        }
        //if nick is empty -> nick = email
        nickName = nickName.count > 0 ? nickName : email.components(separatedBy: "@")[0]
        //start the auth proccess:
        sender.isEnabled = false //can't click Register 2 times in a row
        showProgress(title: "Please Wait")

        Auth.auth().createUser(withEmail: email,
                               password: password) {[weak self] (result, err) in
            if let err = err{
                self?.showError(title: err.localizedDescription)
                sender.isEnabled = true
                return
            }

            guard let user = result?.user else {
                self?.showError(title: "No User") //"אנא נסה שוב מאוחר יותר"
                sender.isEnabled = true
                return
            }
             //user profile additional info:
            let profileChangeReqeust = user.createProfileChangeRequest()
            profileChangeReqeust.displayName = nickName
            
            profileChangeReqeust.commitChanges { (error) in
                if let error = error {
                    //change name failed
                    self?.showError(title: "Nick name not set",
                                    subtitle: error.localizedDescription)
                    sender.isEnabled = true
                }else {
                    self?.showSuccess(title: "Done!")
                    Router.shared.determineRootViewController()
                }
            }
        }
    }
}




//PKHUD:
//validate email -> show error if not valid
//validate password -> show error if not valid
protocol ShowHUD {
    //list of abstract methods
    //properties
    //protocol extensions for default implementation
}
extension ShowHUD{
    func showProgress(title:String, subtitle: String? = nil){
        HUD.show(.labeledProgress(title: title, subtitle: subtitle))
    }
    
    func showError(title:String, subtitle: String? = nil){
        HUD.flash(.labeledError(title: title, subtitle: subtitle), delay: 3)
    }
    
    func showLabel(title:String){
        HUD.flash(.label(title), delay: 3)
    }
    
    func showSuccess(title:String, subtitle: String? = nil){
        HUD.flash(.labeledSuccess(title: title, subtitle: subtitle) ,delay: 3)
    }
}
extension UIViewController: ShowHUD{}

//user validation in our project:
//in addition to HUD
protocol UserValidation: ShowHUD {
    //1) you must have a TextField called emailTextField
    var emailTextField: UITextField!{get}
    var passwordTextField: UITextField!{get}
}

//client side validation (אין טעם לנסות משהו שברור שלא יעבוד)
extension UserValidation{
    
    var isEmailValid: Bool{
        //professional code for email checking
        guard emailTextField.isEmail() else {
            showError(title: "Email must be valid")
            return false
        }
        return true
    }
    
    var isPasswordValid: Bool{
        guard let password = passwordTextField.text, password.count >= 6  else {
            showError(title: "Password must be valid")
            return false
        }
        return true
    }
}

extension LoginViewController: UserValidation{}
extension RegisterViewController: UserValidation{}
 
