//
//  HomeAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class HomeAuthViewController: UIViewController {
  
  let titleLabel = AOTitleLabel(textAlignment: .center, fontSize: 50)
  let signupButton = AOButton(backgroundColor: Constants.AppColorPalette.orangeYellow, title: "Sign Up")
  let loginButton = AOButton(backgroundColor: .clear, title: "Log in")
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureAuthButtons()
  }
  
  
  private func configureAuthButtons() {
    signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
    loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    
    let buttons = [signupButton, loginButton]
      for item in buttons {
        item.layer.cornerRadius = 15
        item.layer.borderColor = Constants.AppColorPalette.richBlackFOGRA39.cgColor
        item.layer.borderWidth = 2
        item.setTitleColor(Constants.AppColorPalette.richBlackFOGRA39, for: .normal)
    }
  }
  
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    titleLabel.text = Constants.Title.AppName
    
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
  
  
  @objc func signupButtonPressed() {
    let signupVC = SignupAuthViewController()
    let navController = UINavigationController(rootViewController: signupVC)
    present(navController, animated: true)
  }
  
  
  @objc func loginButtonPressed() {
    print("Log in button pressed")
  }
}
