//
//  HomeTableViewCell.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 27/03/2022.
//

import UIKit


class HomeTableViewCell: UITableViewCell {

    //MARK:- Outlets
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var bodyTextlabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var proiflpictureImageView: UIImageView!
    
  
    
    func configureCell(post :BlogPost)  {
        self.bodyTextlabel.text = post.text
        self.usernameLabel.text = post.postUserName
        self.dateLabel.text = "\(post.date)"
        self.counterLabel.text = "\(post.likesCounter)"
        
        if post.image != "" {
            StorageManager.shared.downloadImage(imageUrl: post.image) { (downloadedImage) in
                guard let image = downloadedImage else {return}
                self.proiflpictureImageView.image =  image
            }
            
        } else {
            self.proiflpictureImageView.image = UIImage(named: "avatar")
        }
        
        
       
        
//        self.profilePictureImageView.image
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        proiflpictureImageView.layer.cornerRadius = proiflpictureImageView.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    @IBAction func likeButton(_ sender: Any) {
        
        let image =  UIImage(systemName: "heart.fill")
    
        self.likeButton.setImage(image, for: .normal)
        
        
        
    }
    
}
