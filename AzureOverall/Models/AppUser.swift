//
//  AppUser.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AppUser {
  let email: String?
  let uid: String?
  let dateCreated: Date?
  
  init(from user: User) {
    self.email = user.email
    self.uid = user.uid
    self.dateCreated = user.metadata.creationDate
  }
  
  private var fieldsDict: [String: Any] {
    return [ "email" : email ?? "" ]
  }
}
