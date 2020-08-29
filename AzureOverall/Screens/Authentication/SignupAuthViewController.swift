//
//  SigninAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class SignupAuthViewController: UIViewController {
  
  let firstNameTextField = UITextField()
  let lastNameTextField = UITextField()
  let emailTextField = UITextField()
  let passwordTextField = UITextField()
  let actionButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: "Create account")
  let padding: CGFloat = 25

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureNavigationBar()
    constrainUIElements()
    configureTextFields()
    configureActionButton()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
  }

  private func configureNavigationBar() {
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = cancelButton
  }
  
  private func constrainUIElements() {
    let itemViews = [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, actionButton]
    for itemView in itemViews {
      
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding / 2),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding / 2),
        itemView.heightAnchor.constraint(equalToConstant: 50)
      ])
    }
    
    NSLayoutConstraint.activate([
      firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: padding),
      emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: padding),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
      actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding)
    ])
  }
  
  
  func configureTextFields() {
    firstNameTextField.placeholder = "First Name"
    lastNameTextField.placeholder = "Last Name"
    emailTextField.placeholder = "Email"
    passwordTextField.placeholder = "Password"
    
    let itemViews = [firstNameTextField, lastNameTextField, emailTextField, passwordTextField]
    for item in itemViews {
      item.borderStyle = .roundedRect
    }
    
    NSLayoutConstraint.activate([
      firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: padding),
      emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: padding),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
    ])
  }
 
  
  func configureActionButton() {
    actionButton.backgroundColor = Constants.AppColorPalette.uaRed
    actionButton.layer.cornerRadius = 15
    actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
  }
  
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  @objc func actionButtonPressed() {
    print("Create account button pressed")
  }
}
