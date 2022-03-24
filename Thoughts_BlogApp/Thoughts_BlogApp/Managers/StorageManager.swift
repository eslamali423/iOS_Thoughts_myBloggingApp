//
//  StorageManager.swift
//  Thoughts_BlogApp
//
//  Created by Eslam Ali  on 23/03/2022.
//

import Foundation
import FirebaseStorage
import ProgressHUD


class StorageManager {
    
    static let shared  = StorageManager()
    private let  storage =  Storage.storage().reference()
    private let storageRefDirectory  = "gs://thoughtsapp-b073d.appspot.com"
    
    private init () {}
    
    //MARK:- Upload Images to Firestore
    func uploadImgage(image : UIImage, directory : String, completion : @escaping ( _ downloadedLink : String?)-> Void)  {
        // create folder in firestore
        let storageRef = Storage.storage().reference(forURL: storageRefDirectory).child(directory)
        
        // convert image to data
        guard let imageData =  image.jpegData(compressionQuality: 5.0) else {return}
        
        // put data into firestore and return the downloaded link
        var task : StorageUploadTask!
        task = storageRef.putData(imageData, metadata: nil, completion: { (data, error) in
            task.removeAllObservers()
            ProgressHUD.dismiss()
            
            guard  data != nil , error == nil else  {
                print("Error Uploading Image .....")
                print (error?.localizedDescription)
                
                return
            }
            storageRef.downloadURL { (url, error) in
                guard let downloadUrl =  url , error == nil else  {
                    print (error?.localizedDescription)
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
                
            }
        })
        
        //observe upload persantage
        task.observe(StorageTaskStatus.progress) { (snapshot) in
            // to get the persantage % for uploading progress
            let progress =  snapshot.progress!.completedUnitCount / snapshot.progress!.totalUnitCount
            ProgressHUD.showProgress(CGFloat(progress))
        }
    }// func uploadImage
    
  
    //MARK:- Download Image
    func downloadImage(imageUrl :  String, completion : @escaping ( _ image : UIImage? )->Void)  {
        let imageFileName = fileNameFromUrl(fileUrl: imageUrl)
        
        if fileExistsInPath(path: imageFileName){
            // ture -> get the image locally
            print("get the image loccallyyyyy")
            if let imageContent = UIImage(contentsOfFile: fileInDocumentDirectory(fileName: imageFileName)){
                completion(imageContent)
            }else{
                print("cant get the image locallyyy")
                completion(UIImage(named: "avatar")!)
            }
        }else  {
            //  get the image form firebase
            if imageUrl != "" {
                let downloadUrl = URL(string: imageUrl)
                let downloadQueue = DispatchQueue (label: "imageDownloadQueue")
                
                downloadQueue.async {
                    let data =  NSData(contentsOf: downloadUrl!)
                    if data != nil {
                        // save the file locally
                        StorageManager.shared.saveFileLocally(fileData: data!, fileName: imageFileName)
                        DispatchQueue.main.async {
                            completion(UIImage(data: data! as Data))
                        }
                    }
                }
            }
            
        }
    }// download Image
    
    
    //MARK:-  Save File (avatar) locally
    func  saveFileLocally(fileData : NSData , fileName : String)  {
        let docUrl = getDocumentURL().appendingPathComponent(fileName, isDirectory: false)
        fileData.write(to: docUrl, atomically: true)
        
    }
    
    
    func uploadProfilePicture()   {
        
    }
    
    func downloadUrlForProfilePicture (user:  User, completion: @escaping (URL?)-> Void)  {
        
    }
    
    func uploadPostHeaderImage(blogPost : BlogPost, image:  UIImage?, completion: @escaping (Bool)-> Void)    {
        
    }
    
    func downloadUrlForPostHeaderImage (blogPost:  BlogPost, completion: @escaping (Bool)-> Void)  {
        
    }
    
    
}

//MARK:- Helper Fucntions
// this fucntion to get file pass (local directory (File Manager))
func getDocumentURL () -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
}
// this function to get the file path after add the file name
func fileInDocumentDirectory(fileName : String) -> String {
    return getDocumentURL().appendingPathComponent(fileName).path
}

func fileExistsInPath(path : String) -> Bool {
    return FileManager.default.fileExists(atPath: fileInDocumentDirectory(fileName: path))
}
