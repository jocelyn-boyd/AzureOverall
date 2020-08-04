//
//  DetailViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/2/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  
  //MARK: Properties
  var recipe: Recipe?
  var recipeInformation = [RecipeInformation]()
  
  let recipeImageView = AOImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20)
  let recipeSummaryLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  
  
  //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemBackground
      configureUI()
      loadSingleRecipeImageAndDetails()
    }


  //MARK: - Private Methods
  private func loadSingleRecipeImageAndDetails() {
    guard let recipe = recipe else { return }
    ImageFetchingService.manager.downloadImage(from: recipe.id) { [weak self] (result) in
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
    
    
    RecipeFetchingService.manager.getSingleRecipe(from: recipe.id) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(data):
          self.recipeTitleLabel.text = data.title
        case let .failure(error):
          print(error)
        }
      }
    }
  }

  
  private func configureUI() {
    [recipeImageView, recipeTitleLabel, recipeSummaryLabel].forEach { view.addSubview($0) }
    
    recipeTitleLabel.numberOfLines = 0
    
    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor),
      
      recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      recipeImageView.heightAnchor.constraint(equalToConstant: 200),
      
      recipeSummaryLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      recipeSummaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      recipeSummaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
    ])
  }
}


