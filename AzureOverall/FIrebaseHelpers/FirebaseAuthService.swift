//
//  FirebaseAuthService.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation
import FirebaseAuth

fileprivate enum GenericError: Error {
  case unknown
}

class FirebaseAuthService {
  
  // MARK: Static Properties
static let manager = FirebaseAuthService()
  
  // MARK: Private Properties
  private let firebaseAuth = Auth.auth()
  
  // MARK: Internal Properties
  public var currentUser: User? {
    return firebaseAuth.currentUser
  }
  
  // MARK: Internal Functions
    public func createNewUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    firebaseAuth.createUser(withEmail: email, password: password) { (result, error) in
      if let createdUser = result?.user {
        onCompletion(.success(createdUser))
      } else {
        onCompletion(.failure(error ?? GenericError.unknown))
      }
    }
  }
  
 public func loginUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in
      if let user = result?.user {
        onCompletion(.success(user))
      } else {
        onCompletion(.failure(error ?? GenericError.unknown))
      }
    }
  }
  
 public func signOutUser() throws {
    try firebaseAuth.signOut()
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
      let sceneDelegate = windowScene.delegate as? SceneDelegate,
      let window = sceneDelegate.window else { return }
    
    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
      let homeAuthVC = HomeAuthViewController()
      window.rootViewController = homeAuthVC
    }, completion: nil)
  }
  
  // MARK: Private initializers
  private init() {}
}



