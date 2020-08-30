//
//  FirebaseAuthService.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
  
  // MARK: Static Properties
  
  static let manager = FirebaseAuthService()
  
  // MARK: Internal Functions
  
  func loginUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    //TODO: Add Implementation
  }
  
  func createNewUser(withEmail email: String, andPassword password: String, onCompletion: @escaping (Result<User, Error>) -> Void) {
    // TODO: Add Implementation
  }
  
  // MARK: Intern Properties
  
  var currentUser: User? {
    // TODO: Add Implementation
  }
  
  // MARK: Private initializers
  
  private init() {}
}



