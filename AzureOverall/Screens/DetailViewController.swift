//
//  DetailViewController.swift
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  //MARK: Properties
  var recipe: Recipe?
  var recipeInformation = [RecipeInformation]()
  
  let recipeImageView = AOImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20, numberOfLines: 0)
  let recipeSummaryLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  
  
  //MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayoutUI()
    loadSingleRecipeImageAndDetails()
  }
  
  
  //MARK: - Private Networking Methods
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
  
  // MARK: Private Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
  }
  
  
  private func configureLayoutUI() {
    let padding: CGFloat = 20
    let itemViews = [recipeImageView, recipeTitleLabel, recipeSummaryLabel]
    for itemView in itemViews { view.addSubview(itemView) }
    
    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor),
      
      recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeImageView.heightAnchor.constraint(equalToConstant: 200),
      
      recipeSummaryLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      recipeSummaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeSummaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
    ])
  }
}
