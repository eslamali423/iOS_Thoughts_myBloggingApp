//
//  PostsTableViewCell.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    //MARK:- Outlets
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    func configureCell(post :BlogPost)  {
        self.bodyLabel.text = post.text
        self.usernameLabel.text = post.postUserName
        self.dateLabel.text = "\(post.date)"
        
        let currentUserId = UserDefaults.standard.string(forKey: KCURRENTUSERID)
        if post.image != "" {
            StorageManager.shared.downloadImage(imageUrl: post.image) { (downloadedImage) in
                guard let image = downloadedImage else {return}
                self.profilePictureImageView.image =  image
            }
            
        } else {
            self.profilePictureImageView.image = UIImage(named: "avatar")
        }
        
        
       
        
//        self.profilePictureImageView.image
    }

    

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
