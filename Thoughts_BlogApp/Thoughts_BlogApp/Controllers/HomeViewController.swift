//
//  HomeViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
       
        let actionSheet = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { (isSuccess) in
                if isSuccess {
                    DispatchQueue.main.async {
                        AuthManager.shared.signOut { (isSuccess) in
                            if isSuccess {
                              let  vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as!
                                    SignInViewController
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            
                            }
                        }
                    }
                }
            }

        }))
        self.present(actionSheet, animated: true, completion: nil)

        
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
