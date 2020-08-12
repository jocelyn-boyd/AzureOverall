//
//  HeaderVC.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/11/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController {
  
  let recipeImage = AOFoodImageView(frame: .zero)
  
  var recipe: Recipe!
  
  init(recipe: Recipe) {
    super.init(nibName: nil, bundle: nil)
    self.recipe = recipe
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUIElements()
    // Do any additional setup after loading the view.
  }
    
  func configureUIElements() {
    recipeImage.downloadImage(fromURL: recipe.id)
  }

}
