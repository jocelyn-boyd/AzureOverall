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
    view.backgroundColor = .purple
    
    let addSignOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonTapped))
    navigationItem.rightBarButtonItem = addSignOutButton
    navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 224 / 255, green: 26 / 255, blue: 79 / 255, alpha: 1)
  }

  @objc func signOutButtonTapped() {
     print("buttonTapped")
   }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
