//
//  SigninAuthViewController.swift
//  AzureOverall aka RecipeBox
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupAuthViewController: UIViewController {
  
  // MARK: UI Element Properties
  let emailTextField = AOTextField(placeholder: Constants.SetTitle.email)
  let passwordTextField = AOTextField(placeholder: Constants.SetTitle.password)
  let actionButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.createAccount)
  private let padding: CGFloat = 25
  
  // MARK: Private Properties
  private var validUserCredentials: (email: String, password: String)? {
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
    configureTextFields()
    configureActionButton()
  }
  
  
  // TODO: Abstract function from view controller
  private func presentGenericController(withTitle: String, andMessage message: String) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  
  // MARK: FirebaseAuth Methods
  private func handleCreateUserResponse(withResult result: Result<User, Error>) {
    let alertTitle: String
    let alertMessage: String
    switch result {
    case let .success(user):
      alertTitle = "Login Success"
      alertMessage = "Logged in user with \(user.email ?? "no email") and \(user.uid)"
    case let .failure(error):
      alertTitle = "Login Failure"
      alertMessage = "An error occured while loggin in: \(error)"
    }
    presentGenericController(withTitle: alertTitle, andMessage: alertMessage)
    
  }
  
  
 private func createNewUserAccount(_ sender: Any) {
    guard let validCredentials = validUserCredentials else { return }
    FirebaseAuthService.manager.createNewUser(withEmail: validCredentials.email,
                                            andPassword: validCredentials.password,
                                            onCompletion: { [weak self] (result) in self?.handleCreateUserResponse(withResult: result)})
  }
  
  
  private func handleInvalidFields() {
    //TODO: Add implementation
  }
  
  
  private func emailFieldIsValid() -> Bool {
    // TODO: Add implementation
    return true
  }
  
  
  // MARK: Private Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
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
  
  // MARK: @objc Methods
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  
  @objc func actionButtonPressed() {
//    print("Create account button pressed")
    createNewUserAccount(actionButton)
  }
}
