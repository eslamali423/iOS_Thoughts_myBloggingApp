//
//  ProfileViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var currentUser : User?
    
    //MARK:- Life Cycle
    @IBOutlet weak var profilePictureImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // usernameLabel.text = UserDefaults.standard.string(forKey: KCURRENTUSEREMAIL)  ?? ""
       
        getUserData()
       // print(UserDefaults.standard.string(forKey: KCURRENTUSERID)!)
    }
    
    
    //MARK:- Get User Data Form Firestore
    func getUserData()  {
        if let data =  UserDefaults.standard.data(forKey: KCURRENTUSER)  {
            do {
                self.currentUser = try JSONDecoder().decode(User.self, from: data)
                
               
            }catch{
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.async {
            self.usernameLabel.text = self.currentUser?.username
            self.BioLabel.text = self.currentUser?.bio
        }
        
//        DatabaseManager.shared.downloadUserFormFirestore(userID: UserDefaults.standard.string(forKey: KCURRENTUSERID)!) { (user) in
//            guard let user = user else  {
//                return
//            }
//            DispatchQueue.main.async {
//                self.BioLabel.text = user.bio
//                self.usernameLabel.text = user.username
//
//            }
//        }
    }
    
    
}
