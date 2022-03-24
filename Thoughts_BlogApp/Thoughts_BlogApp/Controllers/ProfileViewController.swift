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
   
    @IBOutlet weak var profilePictureImageView: UIImageView!
    var viewModel = ProfileViewModel()

    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2
        viewModel.fetchData()
        getUserData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        getUserData()
        
    }
  
    
    
    //MARK:- Get User Data Form Firestore
    func getUserData()  {
       
            DispatchQueue.main.async { [self] in
                self.usernameLabel.text = self.viewModel.currentUser?.username
                self.BioLabel.text = self.viewModel.currentUser?.bio
            
                if viewModel.currentUser?.profilePictureUrl != ""   {
                    guard let url = viewModel.currentUser?.profilePictureUrl else {
                        return
                    }
                    StorageManager.shared.downloadImage(imageUrl: url) { (image) in
                        self.profilePictureImageView.image = image
                    }
                    
                    
                }
                    
                
            
            }
            
            
        
        
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingVC = storyboard?.instantiateViewController(identifier: "SettingsTableViewController") as! SettingsTableViewController
        settingVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingVC, animated: true)
    }
}
