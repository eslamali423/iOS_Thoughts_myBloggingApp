//
//  PostViewModel.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

class PostViewModel {

//var posts : [BlogPost] = []
    var posts = BehaviorSubject(value: [BlogPost]())

func fetchPosts()  {
    guard let currentId = UserDefaults.standard.string(forKey: KCURRENTUSERID) else {
        return
    }
    print("fetching posts in viewmModel")
   
  
    
    
    DatabaseManager.shared.dowloadPostsFormFirestore(userId: currentId) { (queryPosts) in
     //   guard queryPosts.count > 0 else {return}
      
        self.posts.on(.next(queryPosts))
        print(queryPosts.count)
        //print(queryPosts)
    }
    
}
}
