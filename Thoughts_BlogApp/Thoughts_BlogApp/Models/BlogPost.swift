//
//  BlogPost.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct BlogPost : Codable, Equatable {
   
    let postId : String
    let postUserName : String
    let image : String
    let text : String
    let date : Date
    
}


