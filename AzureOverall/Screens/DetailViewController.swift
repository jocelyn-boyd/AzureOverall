//
//  DetailViewController.swift
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var recipe: Recipe?
  var recipeInformation = [RecipeInformation]()
  
  let recipeImageView = AOFoodImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20, numberOfLines: 0)
  let recipeSummaryLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureLayoutUI()
    loadSingleRecipeDetails()
  }
  
  
  private func loadSingleRecipeDetails() {
    guard let recipe = recipe else { return }
    recipeTitleLabel.text = recipe.title
 
    RecipeFetchingService.manager.fetchSingleRecipe(from: recipe.id) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(data):
          self.loadRecipeImage(from: data.image)
          
          if data.vegan == false {
            self.recipeSummaryLabel.text = "Not Vegan"
          }
          
        case let .failure(error):
          print(error)
        }
      }
    }
  }

  
 private func loadRecipeImage(from urlString: String) {
    ImageFetchingService.manager.fetchImage(from: urlString) { (result) in
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
