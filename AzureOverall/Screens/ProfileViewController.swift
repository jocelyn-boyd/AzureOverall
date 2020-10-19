//
//  ProfileViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/4/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let addSignOutButton = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutButtonPressed))
        navigationItem.leftBarButtonItem = addSignOutButton
        navigationItem.leftBarButtonItem?.tintColor = Constants.AppColorPalette.uaRed
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissProfileVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.rightBarButtonItem?.tintColor = Constants.AppColorPalette.uaRed
    }
    
    // MARK: - @objc Methods
    @objc private func dismissProfileVC() {
        dismiss(animated: true)
    }
    
    @objc private func signOutButtonPressed() {
        do {
            try FirebaseAuthService.manager.signOutUser()
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}
