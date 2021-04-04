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
