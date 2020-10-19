//
//  BookmarkedRecipesListViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 10/19/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class BookmarkedRecipesListViewController: UIViewController {
    
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

