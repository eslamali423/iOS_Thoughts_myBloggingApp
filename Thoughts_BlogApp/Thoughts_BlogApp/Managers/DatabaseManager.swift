//
//  DatabaseManager.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseFirestore


class DatabaseManager {
    
    static let shared  = DatabaseManager()
    private let  database =  Firestore.firestore()
    
    
    private init () {}
    
    public func insert (blogPost : BlogPost, user : User, completion: @escaping (Bool)->Void) {
        
    }
    
    public func getAllPosts ( completion: @escaping ([BlogPost])->Void) {
        
    }

    public func getPosts ( user : User, completion: @escaping ([BlogPost])->Void) {
        
    }
    
    public func insert (user : User,userId : String , completion: @escaping (Bool)->Void) {
      let data =  [
        "username"  :   user.username,
        "email"  : user.email,
 
      ]
        database.collection(KUSERS).document(userId).setData(data) { error in
            completion(error == nil)
            
        }
    }
    
    
}
