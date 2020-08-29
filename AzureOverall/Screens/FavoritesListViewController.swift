//
//  FavoritesListViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/28/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}
