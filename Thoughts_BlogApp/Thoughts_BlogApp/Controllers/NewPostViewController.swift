//
//  NewPostViewController.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import UIKit

class NewPostViewController: UIViewController {

   
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create A new Post"
        navigationItem.largeTitleDisplayMode = .never
        postButton.layer.shadowRadius = postButton.frame.size.width / 2
        
        
    }
    
    
    
    @IBAction func postButton(_ sender: Any) {
        guard let currentId = UserDefaults.standard.string(forKey: KCURRENTUSERID) else {return}
    
        guard let postText = postTextField.text, !postText.isEmpty else {
            return
        }
        DatabaseManager.shared.downloadUserFormFirestore(userID: currentId) { (user) in
            
            guard let currentUser = user else {return}
            
            let newPost =  BlogPost(postId: UUID().uuidString,userId: currentId ,postUserName: currentUser.username, image: currentUser.profilePictureUrl, text: postText , date: "\(Date())")
            DatabaseManager.shared.savePostToFirestore(userId: currentId, post: newPost) { (isSuccess) in
                if isSuccess {
                    print("Posts added to firebase")
                    self.navigationController?.popViewController(animated: true)
                }else  {
                    print("error adding post to firebase")
                }
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
