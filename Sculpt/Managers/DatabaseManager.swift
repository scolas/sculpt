//
//  DatabaseManager.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    //video 5 5:20
    public func findUser(with email: String, completion: @escaping (User?) -> Void){
        let ref = database.collection("users")
        //video 5 sign in and up 11:14
        ref.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({ User(with: $0.data()) }),
                  error == nil else {
                completion(nil)
                return
            }
           //get first user where email are the same
            let user = users.first(where: {$0.email == email})
            completion(user)
        }
    }
    
    public func createUser(newUser: User, completion: @escaping(Bool) -> Void){
        //database documents takes dictionaries/ so we use codable and encodeable to ture our modles/struct to dictionaries
        let reference = database.document("users/\(newUser.username)")
        guard  let data = newUser.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { (error) in
            completion(error == nil)
        }
    }
}
