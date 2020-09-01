//
//  LoginAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginAuthViewController: UIViewController {
  
  // MARK: Properties
  let emailTextField = AOTextField(placeholder: Constants.SetTitle.email)
  let passwordTextField = AOTextField(placeholder: Constants.SetTitle.password)
  
  let actionButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.login)
  
  let padding: CGFloat = 25
  
  // MARK: Private Properties
  private var validUserCrendentials: (email: String, password: String)? {
    guard let email = emailTextField.text,
          let password = passwordTextField.text,
      emailFieldIsValid() else {
        return nil
    }
    return (email, password)
  }
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureNavigationBar()
    configureTextFields()
    configureActionButton()
  }
  
  private func presentGenericAlert(withTitle title: String, andMessage message: String) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  private func transitionToSearchVC() {
    let tabBarController = AOTabBarController()
    view.window?.rootViewController = tabBarController
    view.window?.makeKeyAndVisible()
  }
  
  // MARK: Firebase Methods
  private func handleLoginResponse(withResult result: Result<User, Error>) {
    let alertTitle: String
    let alertMessage: String
    switch result {
    case let .success(user):
      alertTitle = "Login Success"
      alertMessage = "Logged in user with email \(user.email ?? "no email") and \(user.uid)"
    case let .failure(error):
      alertTitle = "Login Failure"
      alertMessage = "An error occured while loggin in: \(error)"
    }
    presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
  }
  
  private func signinUser(_ sender: Any) {
    guard let validCredentials = validUserCrendentials else {
      handleInvalidFields()
      return
    }
    FirebaseAuthService.manager.loginUser(withEmail: validCredentials.email,
                                          andPassword: validCredentials.password) { [weak self ](result) in
                                            self?.handleLoginResponse(withResult: result)
    }
  }
  
  private func handleInvalidFields() {
    // TODO: Add implementation
  }
  
  private func emailFieldIsValid() -> Bool {
    // TODO: Add implementation
    return true
  }
  
  // MARK: Private Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
  }
  
  
  private func configureNavigationBar() {
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissLoginAuthVC))
    navigationItem.rightBarButtonItem = cancelButton
  }
  
  
  private func configureTextFields() {
    let itemViews = [emailTextField, passwordTextField]
    for item in itemViews {
      view.addSubview(item)
      
      NSLayoutConstraint.activate([
        item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        item.heightAnchor.constraint(equalToConstant: 40)
      ])
    }
    
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding)
    ])
  }
  
  
  private func configureActionButton() {
    view.addSubview(actionButton)
    actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 5),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 5),
      actionButton.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  // MARK: @objc Methods
  @objc func dismissLoginAuthVC() {
    dismiss(animated: true)
  }
  
  
  @objc func actionButtonPressed() {
     print("Login button pressed")
//    signinUser(actionButton)
    dismissLoginAuthVC()
    transitionToSearchVC()
   }
}

extension LoginAuthViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
