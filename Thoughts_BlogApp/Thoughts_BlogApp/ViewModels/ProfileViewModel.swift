//
//  ProfileViewModel.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 24/03/2022.
//

import Foundation

class ProfileViewModel {
    
    var currentUser : User?

    //MARK:- Get User Data Form Firestore
    func fetchData()  {
        if let data =  UserDefaults.standard.data(forKey: KCURRENTUSER)  {
            do {
                self.currentUser = try JSONDecoder().decode(User.self, from: data)
                
               
            }catch{
                print(error.localizedDescription)
            }
        }
//        DatabaseManager.shared.downloadUserFormFirestore(userID: UserDefaults.standard.string(forKey: KCURRENTUSERID)!) { (user) in
//            guard let user = user else  {
//                return
//            }
//            DispatchQueue.main.async {
//                self.BioLabel.text = user.bio
//                self.usernameLabel.text = user.username
//
//            }
//        }
    }
    
    
}
