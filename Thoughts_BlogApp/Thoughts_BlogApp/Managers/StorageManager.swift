//
//  StorageManager.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseStorage


class StorageManager {
    
    static let shared  = StorageManager()
    private let  container =  Storage.storage().reference()
    
    
    private init () {}
    
    
    func uploadProfilePicture()   {
        
    }
    
    func downloadUrlForProfilePicture (user:  User, completion: @escaping (URL?)-> Void)  {
        
    }
    
    func uploadPostHeaderImage(blogPost : BlogPost, image:  UIImage?, completion: @escaping (Bool)-> Void)    {
        
    }
    
    func downloadUrlForPostHeaderImage (blogPost:  BlogPost, completion: @escaping (Bool)-> Void)  {
        
    }
    
    
}
