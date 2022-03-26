//
//  HomeViewModel.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 26/03/2022.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    


var posts = BehaviorSubject(value: [BlogPost]())


func fetchAllPosts() {

    DatabaseManager.shared.downloadAllPostsFromFirestore { (queryPosts) in
        self.posts.on(.next(queryPosts))
    }
    
    
}

}
