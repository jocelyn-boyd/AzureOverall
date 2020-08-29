//
//  AOTabBarController.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOTabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBarController()
  }
  
  func configureTabBarController() {
    viewControllers = [createSearchVC(), createBookmarkedRecipeListVC(), createFavoritesListVC()]
    UITabBar.appearance().tintColor = Constants.AppColorPalette.uaRed
  }
  
    
  func createSearchVC() -> UINavigationController {
    let searchVC            = SearchViewController()
    searchVC.title          = "Search"
    searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    return UINavigationController(rootViewController: searchVC)
  }
  
  
  func createBookmarkedRecipeListVC() -> UINavigationController {
     let bookmarkedRecipesListVC = BookmarkedRecipesListViewController()
     bookmarkedRecipesListVC.title = "Saved"
     bookmarkedRecipesListVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark.fill"), tag: 1)
     return UINavigationController(rootViewController: bookmarkedRecipesListVC)
   }
  
  
  func createFavoritesListVC() -> UINavigationController {
    let favoritesVC = FavoritesListViewController()
    favoritesVC.title = "Favorites"
    favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
    return UINavigationController(rootViewController: favoritesVC)
  }
}
