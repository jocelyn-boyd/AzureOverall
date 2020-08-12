//
//  DetailVC.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/11/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

  let headerView = UIView()
  var recipe: Recipe?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  func getInfo() {
  
  }
  
  func configureElements(with recipe: Recipe) {
    self.add(childVC: HeaderVC(recipe: recipe, to: self.headerView))
  }
  

}
