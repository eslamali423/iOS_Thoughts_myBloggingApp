//
//  SignInViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayouts()
        
    }
    //MARK:- Configure Layouts
    func configureLayouts()  {
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        loginButton.layer.cornerRadius = 20
        
    }
    
    
    //MARK:- Did Tap Login Button
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty,
              let password =  passwordField.text, !password.isEmpty else {
            return
        }
        AuthManager.shared.signIn(email: email, password: password) { (isSuccess, currentUserId) in
            if isSuccess && currentUserId != "" {
                DispatchQueue.main.async {
                   // set values in user defaults
                    DatabaseManager.shared.downloadUserFormFirestore(userID: currentUserId) { (user) in
                        guard let user =  user  else {
                            print("cant get user ")
                            return}
                        print("get user form firestire")
                        DatabaseManager.shared.saveUserLocally(user, userId: currentUserId)
                    }
                    
//                    UserDefaults.standard.set( currentUserId ,forKey: KCURRENTUSERID)
//                    UserDefaults.standard.set( email ,forKey: KCURRENTUSEREMAIL)
                    
                    print("\(currentUserId)")
                    let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as!
                        TabBarViewController
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true)
                }
                
            }
        }
        
        
    }
    
    
    //MARK:- Did tap Create User Button
    @IBAction func createUserButton(_ sender: Any) {
        let registrationVc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        present(registrationVc, animated: true)
        
    }
    
    
    
}
