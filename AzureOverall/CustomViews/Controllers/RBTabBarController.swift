//
//  AOTabBarController.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RBTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureTabBarController()
	}
	
	private func configureTabBarController() {
		viewControllers = [createSearchVC(), createBookmarkedRecipeListVC()]
		
		UITabBar.appearance().tintColor = .systemBlue
	}
	
	private func createSearchVC() -> UINavigationController {
		let searchVC            = SearchViewController()
		searchVC.title          = "Search"
		searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}
	
	private func createBookmarkedRecipeListVC() -> UINavigationController {
		let bookmarkedRecipesListVC = SavedListViewController()
		bookmarkedRecipesListVC.title = "Saved"
		bookmarkedRecipesListVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark.fill"), tag: 1)
		return UINavigationController(rootViewController: bookmarkedRecipesListVC)
	}
}
