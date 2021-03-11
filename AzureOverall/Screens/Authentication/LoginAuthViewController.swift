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
    private let emailTextField = RBTextField(placeholder: Constants.SetTitle.email)
    private let passwordTextField = RBTextField(placeholder: Constants.SetTitle.password)
    private let loginAuthButton = RBButton(backgroundColor: Constants.AppColorPalette.uaRed, title: Constants.SetTitle.login)
    
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
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureViewController()
        configureInputTextFields()
        configureLoginAuthActionButton()
        createDismissKeyboardTapGesture()
    }
    
    private func presentGenericAlert(withTitle title: String, andMessage message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
                window.rootViewController = RBTabBarController()
            } else {
                window.rootViewController = { () -> RBTabBarController in
                    let searchVC = RBTabBarController()
                    return searchVC
                }()
            }
        }, completion: nil)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Firebase Methods
    private func handleLoginResponse(withResult result: Result<User, Error>) {
        let alertTitle: String
        let alertMessage: String
        switch result {
        case let .success(user):
            transitionToSearchVC()
            print("Logged in user with email \(user.email ?? "no email") and \(user.uid)")
        case let .failure(error):
            alertTitle = "Login Failure"
            alertMessage = "An error occured while logging in: \(error.localizedDescription)"
            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
        }
    }
    
    private func signinUser(_ sender: Any) {
        guard let validCredentials = validUserCredentials else { return }
        
        guard validCredentials.email.isValidEmail else {
            let alertTitle = "Error"
            let alertMessage = "Please enter a valid email"
            presentGenericAlert(withTitle: alertTitle, andMessage: alertMessage)
            return }
        
        FirebaseAuthService.manager.loginUser(withEmail: validCredentials.email,
                                              andPassword: validCredentials.password) { [weak self ](result) in
            self?.handleLoginResponse(withResult: result)
        }
    }
    
    // MARK: Private Configuration Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissLoginAuthVC))
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    private func configureInputTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
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
    
    private func configureLoginAuthActionButton() {
        view.addSubview(loginAuthButton)
        loginAuthButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginAuthButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            loginAuthButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 5),
            loginAuthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 5),
            loginAuthButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: @objc Methods
    @objc private func dismissLoginAuthVC() {
        dismiss(animated: true)
    }
    
    @objc private func actionButtonPressed() {
        signinUser(loginAuthButton)
    }
}

// MARK: - Extensions
extension LoginAuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
