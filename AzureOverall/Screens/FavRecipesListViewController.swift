//
//  FavRecipesViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 3/11/21.
//  Copyright © 2021 Jocelyn Boyd. All rights reserved.
//

import UIKit

class FavRecipesListViewController: UIViewController {

    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Private Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
