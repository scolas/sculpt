//
//  StorageManager.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage().reference()
    
    // 4:13 camera video 2nd to last
    public func uploadPost(
        data: Data?,
        id: String,
        completion: @escaping (URL?) -> Void
    ){
        guard let username = UserDefaults.standard.string(forKey: "username"),
              let data = data else {
            return
        }
        let ref = storage.child("\(username)/posts/\(id).png")
        ref.putData(data, metadata: nil) { _, error in
            ref.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
    public func downloadURL(for post: Post, completion: @escaping (URL?) -> Void){
        guard let ref = post.storageReference else {
            completion(nil)
            return
        }
        storage.child(ref).downloadURL { url, _ in
            completion(url)
        }
    }
    
    public func profilePictureURL(for username: String, completion: @escaping (URL?) -> Void){
        storage.child("\(username)/profile_picture.png").downloadURL { url, _ in
            completion(url)
        }
    }
    // 18:02 sign up video 3
    public func uploadProfilePicture(
        username:String,
        data: Data?,
        completion: @escaping (Bool) -> Void
    ){
        guard let data = data else {
            return
        }
        storage.child("\(username)/profile_picture.png").putData(data, metadata: nil) { (_, error) in
            completion(error == nil)
        }
    }
}
