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
    viewControllers = [createSearchNC()]
    UITabBar.appearance().tintColor = UIColor(displayP3Red: 224 / 255, green: 26 / 255, blue: 79 / 255, alpha: 1)
  }
  
    
  func createSearchNC() -> UINavigationController {
    let searchVC            = SearchViewController()
    searchVC.title          = "Search"
    searchVC.tabBarItem     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
    return UINavigationController(rootViewController: searchVC)
  }
}
