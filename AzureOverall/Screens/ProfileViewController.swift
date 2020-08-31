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
    navigationItem.leftBarButtonItem?.tintColor = Constants.AppColorPalette.uaRed
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissProfileVC))
    navigationItem.rightBarButtonItem = doneButton
    navigationItem.rightBarButtonItem?.tintColor = Constants.AppColorPalette.uaRed
  }

  @objc func dismissProfileVC() {
     dismiss(animated: true)
   }
  
  @objc func signOutButtonTapped() {
     print("buttonTapped")
   }
}
