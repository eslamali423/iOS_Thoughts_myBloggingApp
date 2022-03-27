//
//  DatabaseManager.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


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
    
    
    
    
    //MARK:- USER
    
    //MARK:- uploade user data to firestore database after registration statment
    public func saveUserToFirestore (user : User,userId : String , completion: @escaping (Bool)->Void) {
        let data =  [
            KUSERNAME  :   user.username,
            KEMAIL  : user.email,
            KBIO : user.bio,
            KPROFILEURL : user.profilePictureUrl
            
        ]
        database.collection(KUSERS).document(userId).setData(data) { error in
            completion(error == nil)
            
        }
    }
    
    
    //MARK:- download user data form firestore database after login statment
    func downloadUserFormFirestore(userID : String, completion: @escaping (User?)->Void)  {
        database.collection(KUSERS).document(userID).getDocument { (snapshot, error) in
            guard let document = snapshot?.data() as? [String:String] , error == nil else {
                print("no data Found")
                print(error?.localizedDescription)
                return
            }
            
            let username =  document[KUSERNAME]
            let email = document[KEMAIL]
            let bio = document[KBIO]
            let profileUrl = document[KPROFILEURL]
            let user =  User(username: username!, email: email!, bio: bio!, profilePictureUrl: profileUrl!)
            
            completion(user)
            
        }
    }
    
    //MARK:- save User Locally
    func saveUserLocally(_ user : User, userId : String) {
        do{
            let data = try  JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: KCURRENTUSER)
            UserDefaults.standard.set( userId ,forKey: KCURRENTUSERID)
            //        UserDefaults.standard.set( userId ,forKey: KCURRENTUSERNAME)
            
            
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    //MARK:- POST
    
    //MARK:- Save Post To Firestore
    func savePostToFirestore(userId : String, post: BlogPost ,completion: @escaping (Bool)->Void)  {
        let data : [String : Any] = [
            KPOSTID : post.postId,
            KPOSTUSERNAME : post.postUserName,
            KPOSTTEXT  : post.text,
            KPOSTDATE : (post.date),
            KPOSTPICTURE : post.image,
            KPOSTUSERID : userId,
            KPOSTLIKESCOUNTER : post.likesCounter
            
        ]
        
        
        
        database.collection(KPOSTS).document(KTEXTPOSTS).collection(userId).document(post.postId).setData(data) { error in
            
            completion(error == nil)
            
        }
        
    }
    
    //MARK:- Download User Post From Firestore
    
    func downloadUserPostsFormFirestore(userId : String, completion: @escaping ( _ allPosts : [BlogPost])->Void)  {
        
        database.collection(KPOSTS).document(KTEXTPOSTS).collection(userId).getDocuments { querySnapshot, error in
            //var posts : [BlogPost] = []
        
   
            
            let posts : [BlogPost] = querySnapshot!.documents.compactMap({ dictionary in
         
                         guard let id =  dictionary[KPOSTID] as? String,
                               let postUserId = dictionary[KPOSTUSERID] as? String,
                               let  username =  dictionary[KPOSTUSERNAME] as? String,
                               let text =  dictionary[KPOSTTEXT] as? String,
                               let date =   dictionary[KPOSTDATE] as? String,
                               let counter =  dictionary[KPOSTLIKESCOUNTER] as? Int,
                               let  image =  dictionary[KPOSTPICTURE] as? String else {
                        print("error post fetch converstion ")
                             return nil
                         }
                       
                let post = BlogPost(postId: id,userId: postUserId ,postUserName: username, image: image, text: text, date: date, likesCounter: counter)
                               return post
            })
            completion(posts)
           // print(posts.count)
            
        }
    }
    
    
    //MARK:- Download All Posts form Firestore
    func downloadAllPostsFromFirestore (completion : @escaping ([BlogPost])->Void) {
        database.collection(KUSERS).getDocuments { (snapshot, error) in
            guard let documents =  snapshot?.documents, error == nil else {return}
            var allPosts : [BlogPost] = []
            for document in documents {

              if document == document {
                print("IIIIDDDDD:::::::: \(document.documentID)")
                DatabaseManager.shared.downloadUserPostsFormFirestore(userId: document.documentID) { (downloadedPosts) in
                    guard downloadedPosts != nil  else {return}
                   // print(downloadedPosts.count)
                    if downloadedPosts.count > 0 {
                        allPosts.append(contentsOf: downloadedPosts)
                        completion(allPosts)
                    }
                    

                }
                 }
                   }
          //  completion(allPosts)
            
            
        }
        }
    }
          
        

        
        
           


    
    
    



//                for _ in querySnapshot!.documents {
//
//                 let post = querySnapshot!.documents.compactMap { (snapshot) -> BlogPost? in
//                        return try? snapshot.data(as: BlogPost.self)
//                    }
//
//                    posts.append(contentsOf: post)
//
//                }
//                print(posts)
//            completion(posts)
    






//
//            let posts : [BlogPost] = documents.compactMap({ dictionary in
//                guard let id = dictionary[KPOSTS] as? String,
//                      let username = dictionary[KPOSTUSERNAME] as? String,
//                      let image = dictionary[KPOSTPICTURE] as? String,
//                      let text = dictionary[KPOSTTEXT] as? String,
//                      let date = dictionary[KPOSTDATE] as? Date else {
//                    print("ERRRRRORRRRR")
//                    return nil
//                }
//                let post = BlogPost(postId: id,userId: userId ,postUserName: username, image: image, text: text, date: date)
//                return post
//            })
//            completion(posts)
//            print(posts.count)
//
//        }
//
//            self.database.collection(KPOSTS).document(userId).collection("TextPost").getDocuments { (snapshot, error) in
//
//                        guard let documents = snapshot?.documents , error == nil else {
//                            print("no data Found")
//                            return
//                        }
//                        print(documents)
//
//                let map = snapshot?.documents.compactMap({ (snap) -> BlogPost in
//                    return try? snap.data(as: BlogPost.self)
//
//                })
//
//
//
//                        let allPosts = documents.compactMap { (snapshot) -> BlogPost? in
//                            return try? snapshot.data(as: BlogPost.self)
//                        }
//                       completion(allPosts)
//                        print(allPosts.count)



//            let posts : [BlogPost] = documents.compactMap({ dictionary in
//
//                guard let id =  dictionary[KPOSTID] as? String,
//                      let  username =  dictionary[KPOSTUSERNAME] as? String,
//                      let text =  dictionary[KPOSTTEXT] as? String,
//                      let date =   dictionary[KPOSTDATE] as? Date,
//                      let  image =  dictionary[KPOSTPICTURE] as? String else {
//               print("error post fetch converstion ")
//                    return nil
//                }
//                print(dictionary["username"])
//
//                let post = BlogPost(id: id, username: username, userProfilePictureUrl: image, text: text, date: date )
//
//                return post
//
//            })
//            print(posts.count)
//            completion(posts)
//



//   documents.compactMap{ $0.data()}
