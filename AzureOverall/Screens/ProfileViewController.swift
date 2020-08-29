//
//  ProfileViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/4/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      configureViewController()
    }
    
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    
    let addSignOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonTapped))
    navigationItem.leftBarButtonItem = addSignOutButton
    navigationItem.leftBarButtonItem?.tintColor = Constants.Color.uaRed
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
    navigationItem.rightBarButtonItem?.tintColor = Constants.Color.uaRed
  }

  @objc func dismissVC() {
     dismiss(animated: true)
   }
  
  @objc func signOutButtonTapped() {
     print("buttonTapped")
   }
}
