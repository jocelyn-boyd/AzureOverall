//
//  SigninAuthViewController.swift
//  AzureOverall aka RecipeBox
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupAuthViewController: UIViewController {
  
  // MARK: - UI Element Properties
  let titleLabel = AOTitleLabel(textAlignment: .center, fontSize: 25)
  let emailTextField = AOTextField(placeholder: Constants.SetTitle.email)
  let passwordTextField = AOTextField(placeholder: Constants.SetTitle.password)
  let authActionButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.signup)
  
  // MARK: - Private Properties
  private let padding: CGFloat = 25
  
  private var validUserCredentials: (email: String, password: String)? {
    guard let email = emailTextField.text, !email.isEmpty,
      let password = passwordTextField.text, !password.isEmpty else {
        let alertTitle = "Required"
        let alertMessage = "Please fill in all fields"
        presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
        return nil
    }
    return (email, password)
  }
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureInputTextFields()
    configureSignupAuthActionButton()
    createDismissKeyboardTapGesture()
  }
  
  // MARK: - Private Methods
  private func presentGenericAlert(withTitle: String, andMessage message: String) {
    let alertVC = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    present(alertVC, animated: true, completion: nil)
  }
  
  private func transitionToSearchVC() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
      let sceneDelegate = windowScene.delegate as? SceneDelegate,
      let window = sceneDelegate.window else {
        return
    }
    UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromTop, animations: {
      if FirebaseAuthService.manager.currentUser != nil {
        window.rootViewController = AOTabBarController()
      } else {
        window.rootViewController = { () -> AOTabBarController in
          let searchVC = AOTabBarController()
          return searchVC
        }()
      }
    }, completion: nil)
  }
  
  private func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
  }
    
  // MARK: - FirebaseAuth Methods
  private func handleCreateUserResponse(withResult result: Result<User, Error>) {
    switch result {
    case let .success(user):
      transitionToSearchVC()
      print("Logged in user with email \(user.email ?? "no email") and \(user.uid)")
    case let .failure(error):
      let alertTitle = "Login Failure"
      let alertMessage = "An error occured while signing in: \(error.localizedDescription)"
      presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
    }
  }
  
  private func createNewUserAccount(_ sender: Any) {
    guard let validCredentials = validUserCredentials else { return }
    
    guard validCredentials.email.isValidEmail else {
      let alertTitle = "Error"
      let alertMessage = "Please enter a valid email"
      presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
      return }
        
    FirebaseAuthService.manager.createNewUser(withEmail: validCredentials.email, andPassword: validCredentials.password) { [weak self] (result) in
      self?.handleCreateUserResponse(withResult: result)
    }
  }
  
  // MARK: - Private Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    titleLabel.text = "Create An Account"
    titleLabel.numberOfLines = 0
  
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSignupAuthVC))
    navigationItem.rightBarButtonItem = cancelButton
  }
  
  private func configureInputTextFields() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
    passwordTextField.isSecureTextEntry = true
    
    let itemViews = [titleLabel, emailTextField, passwordTextField]
    for itemView in itemViews {
      view.addSubview(itemView)
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding / 2),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding / 2),
        itemView.heightAnchor.constraint(equalToConstant: 40)
      ])
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding)
    ])
  }
  
  func configureSignupAuthActionButton() {
    view.addSubview(authActionButton)
    authActionButton.backgroundColor = Constants.AppColorPalette.uaRed
    authActionButton.addTarget(self, action: #selector(signupAuthButtonPressed), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      authActionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
      authActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 5),
      authActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 5),
    ])
  }
  
  // MARK: @objc Methods
  @objc func dismissSignupAuthVC() {
    dismiss(animated: true)
  }
  
  @objc func signupAuthButtonPressed() {
    createNewUserAccount(authActionButton)
  }
}

// MARK: Extensions
extension SignupAuthViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
