//
//  HomeAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import AVKit

class HomeAuthViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel = AOTitleLabel(textAlignment: .center, fontSize: 50)
    private let signupButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.signup)
    private let loginButton = AOButton(backgroundColor: .clear, title: Constants.SetTitle.login)
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureAuthButtons()
    }
    
    // MARK: - Configuration Methods
    private func configureAuthButtons() {
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        let buttons = [signupButton, loginButton]
        for item in buttons {
            item.layer.borderWidth = 2
            item.layer.borderColor = Constants.AppColorPalette.richBlackFOGRA39.cgColor
            item.setTitleColor(Constants.AppColorPalette.richBlackFOGRA39, for: .normal)
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        titleLabel.text = Constants.SetTitle.AppName
        
        let itemViews = [titleLabel, signupButton, loginButton]
        for itemView in itemViews { view.addSubview(itemView) }
        
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding * 4),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: padding / 2),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    // MARK: - @objc Methods
    @objc private func signupButtonPressed() {
        let signupVC = SignupAuthViewController()
        let navController = UINavigationController(rootViewController: signupVC)
        present(navController, animated: true)
    }
    
    
    @objc private func loginButtonPressed() {
        let loginVC = LoginAuthViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        present(navController, animated: true)
    }
}
