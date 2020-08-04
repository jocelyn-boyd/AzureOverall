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
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20)
  let recipeImageView = AOImageView()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemBackground
      configureUI()
      loadDetails()
      loadImage()
    }

  
  private func loadImage() {
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
  
  private func loadDetails() {
    guard let recipeDetails = recipeDetails else { return }
    RecipeFetchingService.manager.getSingleRecipe(from: recipeDetails.id) { [weak self ](result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case .success:
          self.recipeTitleLabel.text = recipeDetails.title
        case let .failure(error):
          print(error)
          
        }
      }
    }
  }
  
  
  private func configureUI() {
    view.addSubview(recipeTitleLabel)
    view.addSubview(recipeImageView)
    
    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor),
      
      recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      recipeImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  
}
