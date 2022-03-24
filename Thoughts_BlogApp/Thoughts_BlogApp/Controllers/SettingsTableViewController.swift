//
//  SettingsTableViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var profilePicureImageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var bioField: UITextField!
    
    var viewModel = ProfileViewModel()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Profile"
        
        tableView.tableFooterView = UIView()
        viewModel.fetchData()
        configureUserData()

    }

    func configureUserData()  {
        usernameField.text = viewModel.currentUser?.username
        bioField.text = viewModel.currentUser?.bio
        
        if viewModel.currentUser?.profilePictureUrl != ""   {
            guard let url = viewModel.currentUser?.profilePictureUrl else {
                return
            }
            StorageManager.shared.downloadImage(imageUrl: url) { (image) in
                self.profilePicureImageView.image = image
            }
            
            
        }
            
            
            
        }
    
    
    
    //MARK:- TableView
    
    //this function to hide title for tabelview Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "colorTableView")
        return headerView
    }
    // this function to customize the height for section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 10.0
    }
    
    //MARK:- Edit Profile Button
    @IBAction func editProfileButtom(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    
    //MARK:- Logout Button
    @IBOutlet weak var logoutButton: UIView!
    // MARK: - Table view data source

    //MARK:- upload image
    func uploadImage (image : UIImage){
        guard  let currentId = UserDefaults.standard.string(forKey: KCURRENTUSERID) else {return}
       
        let directory = "avatars/" + "_\(currentId)" + ".jpg"
       
        StorageManager.shared.uploadImgage(image: image, directory: directory) { (downloadUrl) in
            guard let downloadUrl = downloadUrl else  {
                print("cant get the link")
                return
            }
            print(downloadUrl)

            guard var currentUser =  self.viewModel.currentUser else {return}
            currentUser.profilePictureUrl = downloadUrl
            
            DatabaseManager.shared.saveUserToFirestore(user: currentUser , userId: currentId) { (isSuccess) in
                if isSuccess{
                    print("OK")
                }else {
                    print("NO")
                }
            }
            DatabaseManager.shared.saveUserLocally(currentUser, userId: currentId)
//
//            user.avatarLink = downloadUrl
//                saveUserLocally(user)
//
//            DatabaseManager.shared.saveUserToFirestore(user: User, userId: currentId!) { (isSuccess) in
//                if isSuccess {
//                    print("user saveed in firestore succesfully")
//                }else {
//                    print("error saving user in firestore")
//                }
//            }
                
            
            // Save Image locally
            let imageData = image.jpegData(compressionQuality: 0.5)! as NSData
            StorageManager.shared.saveFileLocally(fileData: imageData, fileName: currentId)
        }
        
        
    }
    
    
    
}

extension SettingsTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let pickedImage =  info[.editedImage] as? UIImage else {
            return
        }
        self.profilePicureImageView.image = pickedImage
        uploadImage(image: pickedImage)
        
        
        
    }
    
}
