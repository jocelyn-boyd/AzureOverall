//
//  DetailViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/2/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var recipeDetails: Recipe?
  
  lazy var recipeImageView: UIImageView = {
    let image = UIImageView()
    return image
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      loadRecipeDetails()
      configureUI()
    }

  
  private func loadRecipeDetails() {
    guard let recipeDetails = recipeDetails else { return }
    ImageFetchingService.manager.getImage(from: recipeDetails.id) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(image):
          self.recipeImageView.image = image
        case let .failure(error):
          print(error)
        }
      }
    }
  }
  
  
  private func configureUI() {
    view.addSubview(recipeImageView)
    recipeImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      recipeImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  
}
