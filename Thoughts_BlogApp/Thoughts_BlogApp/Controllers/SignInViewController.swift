//
//  SignInViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit

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
    
    func configureLayouts()  {
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        loginButton.layer.cornerRadius = 20

    }
    
    
    //MARK:- Did Tap Login Button
    @IBAction func loginButton(_ sender: Any) {
    }
    
    
//MARK:- Did tap Create User Button
    @IBAction func createUserButton(_ sender: Any) {
        let registrationVc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        present(registrationVc, animated: true)
     
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
