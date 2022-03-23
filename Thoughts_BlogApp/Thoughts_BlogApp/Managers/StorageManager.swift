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
    private let  database =  Storage.storage()
    
    
    private init () {}
    
    
    
}
