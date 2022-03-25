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
