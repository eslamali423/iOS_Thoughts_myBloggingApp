//
//  ProfileViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BioLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
  
   
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var profileViewModel = ProfileViewModel()
    var postViewModel = PostViewModel()
    
    var bag = DisposeBag()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationItem.largeTitleDisplayMode = .never
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2
        profileViewModel.fetchData()
        getUserData()
        bindTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.fetchData()
        postViewModel.fetchPosts()
        getUserData()
        
    }
    
    
    
    //MARK:- Get User Data Form Firestore
    func getUserData()  {
        
        DispatchQueue.main.async { [self] in
            self.usernameLabel.text = self.profileViewModel.currentUser?.username
            self.BioLabel.text = self.profileViewModel.currentUser?.bio
            
            if profileViewModel.currentUser?.profilePictureUrl != ""   {
                guard let url = profileViewModel.currentUser?.profilePictureUrl else {
                    return
                }
                StorageManager.shared.downloadImage(imageUrl: url) { (image) in
                    self.profilePictureImageView.image = image
                }
            }
     
        }

    }
    //MARK:- TableView
    func bindTableView()  {
        postViewModel.posts.bind(to: tableView.rx.items(cellIdentifier: "cell",cellType: PostsTableViewCell.self))
        { row , postItem , cell in
          
            cell.configureCell(post: postItem)
  
        }.disposed(by: bag)
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingVC = storyboard?.instantiateViewController(identifier: "SettingsTableViewController") as! SettingsTableViewController
        settingVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(settingVC, animated: true)
    }
}


