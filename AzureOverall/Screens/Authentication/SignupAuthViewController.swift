//
//  SigninAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class SignupAuthViewController: UIViewController {
  
  let emailTextField = AOTextField(placeholder: Constants.SetTitle.email)
  let passwordTextField = AOTextField(placeholder: Constants.SetTitle.password)
  let actionButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.createAccount)
  
  let padding: CGFloat = 25
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureNavigationBar()
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
  
  
  private func configureTextFields() {
    let itemViews = [emailTextField, passwordTextField]
    for itemView in itemViews {
      view.addSubview(itemView)
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding / 2),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding / 2),
        itemView.heightAnchor.constraint(equalToConstant: 40)
      ])
    }
    
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding)
    ])
  }
  
  
  func configureActionButton() {
    view.addSubview(actionButton)
    
    actionButton.backgroundColor = Constants.AppColorPalette.uaRed
    actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 5),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 5),
    ])
  }
  
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  
  @objc func actionButtonPressed() {
    print("Create account button pressed")
  }
}
