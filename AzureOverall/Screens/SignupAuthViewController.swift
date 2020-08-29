//
//  SigninAuthViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class SignupAuthViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureNavigationBar()
  }
  
  private func configureViewController() {
    view.backgroundColor = .cyan
  }

  private func configureNavigationBar() {
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = cancelButton
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
