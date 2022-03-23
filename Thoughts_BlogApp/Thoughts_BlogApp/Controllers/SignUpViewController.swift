//
//  SignUpViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Create Account"
        
        configureLayouts()
        
        
    }
    
    
    func configureLayouts()  {
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        confirmPasswordField.autocapitalizationType = .none
        confirmPasswordField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.autocorrectionType = .no
        signUpButton.layer.cornerRadius = 20
        
     
    }
    
    
    
    //MARK:- Did Tap Sign Up Button
    @IBAction func signUpButton(_ sender: Any) {
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password =  passwordField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty,
              password == confirmPassword else {
            print("Wworng in inserted Data ")
            return
        }
        // create user
        AuthManager.shared.signUp(email: email, password: password, username:  username) { [weak self] isSuccess in
            if isSuccess {
                
                print("Success")
                self?.dismiss(animated: true)
                
            }else {
                print("failed to create account")
            }
        }
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
