//
//  AuthManager.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseAuth



class AuthManager {
    
    static let shared  = AuthManager()
    private let  auth =  Auth.auth()
    
     var isSignedIn : Bool  {
        return auth.currentUser != nil
    }
    
    private init () {}
    
    //MARK:- Sign Up Function
    func signUp(email : String, password: String,username: String , compeletion: @escaping (Bool)->Void) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty, password.count >= 6 else {
            return
        }
        
        auth.createUser(withEmail: email, password: password) { (authResult, error) in
            guard authResult != nil , error == nil else {
                // error create account
                print("error create account")
                compeletion(false)
                return
                
            }
            // account created successfully
            print("Acconut created succesfully ")
            
            // insert user to firebase
            if authResult?.user != nil {
                let newUser = User(username: username, email: email, bio: "Hey, I'm Using Thoughs App" ,profilePictureUrl: "")
                DatabaseManager.shared.saveUserToFirestore(user: newUser, userId: (authResult?.user.uid)!) { (isInserted) in
                guard isInserted else  {
                    compeletion(false)
                    return
                }
                compeletion(true)
                print("user inserted succcssfully")
                
            }

            }
           
        }
    }
    
    //MARK:- Sign In Function
    func signIn(email : String, password: String, compeletion: @escaping (Bool,String)->Void) {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty, password.count >= 6 else {
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (authResult, error) in
            guard authResult != nil , error == nil else {
              // error login
                print("error login ")
                compeletion(false, "")
                return
                
            }
            // loged in successfully
            print("loged in successfully")
            guard let id = authResult?.user.uid else {return}
            compeletion(true,id)
        }
        
        
    }
    
    //MARK:- Sign Out
    
    func signOut(compeletion: (Bool)->Void) {
        do {
            try auth.signOut()
           UserDefaults.standard.set( nil  ,forKey: KCURRENTUSER)
            UserDefaults.standard.set( nil  ,forKey: KCURRENTUSERID)

            compeletion(true)
        }catch {
            print(error)
            compeletion(false)
            
        }
    }
    
}
