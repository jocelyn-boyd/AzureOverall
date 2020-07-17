//
//  BrowseViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/16/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
  
  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    return sb
  }()
  

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.green
      constrainUIElements()
    }
    
  func constrainUIElements() {
    view.addSubview(searchBar)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

}
