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
    viewControllers = [createSearchVC(), createProfileVC()]
    UITabBar.appearance().tintColor = UIColor(displayP3Red: 224 / 255, green: 26 / 255, blue: 79 / 255, alpha: 1)
  }
  
    
  func createSearchVC() -> UINavigationController {
    let searchVC            = SearchViewController()
    searchVC.title          = "Search"
    searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    return UINavigationController(rootViewController: searchVC)
  }
  
  func createProfileVC() -> UINavigationController {
    let profileVC = ProfileViewController()
    profileVC.title = "Profile"
    profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
    return UINavigationController(rootViewController: profileVC)
  }
}
