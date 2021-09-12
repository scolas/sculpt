//
//  AuthManager.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//
import FirebaseAuth

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    enum AuthError: Error {
        case newuserCreation
        case signInFailed
    }
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.signInFailed))
                return
            }

            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.signInFailed))
                    return
                }

                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                completion(.success(user))
            }
        }
    }
    
    
    public func singUp(
        email: String,
        username: String,
        Password: String,
        profilePicture: Data?,
        completion: @escaping (Result<User, Error>) -> Void
    ){
    //completin tells the caller what the result was . so insted of passing bool. we pass <User or error>
        // Create account
        let newUser = User(username: username, email: email)
        auth.createUser(withEmail: email, password: Password) { (result, error) in
            guard result != nil, error == nil else {
                completion(.failure(AuthError.newuserCreation))
                return
            }
            
            DatabaseManager.shared.createUser(newUser: newUser) { success in
                if success {
                    StorageManager.shared.uploadProfilePicture(
                        username: username,
                        data: profilePicture
                    ) { uploadSuccess in
                        if uploadSuccess {
                            completion(.success(newUser))
                        }else {
                            completion(.failure(AuthError.newuserCreation))
                        }
                    }
                }else {
                    completion(.failure(AuthError.newuserCreation))
                }
            }
        }
    }
    
    public func signOut(
        completion: @escaping (Bool) -> Void
    ){
        do {
            try auth.signOut()
            completion(true)
        } catch  {
            print(error)
            completion(false)
        }
    }
    
    
}
