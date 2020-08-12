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
  let veganLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let vegetarianLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let glutenFreeLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let dairyFreeLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  
  
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
    
          if !data.vegan, !data.vegetarian, !data.dairyFree, !data.glutenFree {
            self.veganLabel.text = "Is Vegan"
            self.vegetarianLabel.text = "Is Vegetarian"
            self.dairyFreeLabel.text = "Is Dairy Free"
            self.glutenFreeLabel.text = "Is Gluten Free"
          } else {
            self.veganLabel.text = "Not Vegan"
            self.vegetarianLabel.text = "Not Vegetarian"
            self.dairyFreeLabel.text = "Not Dairy Free"
            self.glutenFreeLabel.text = "Not Gluten Free"
          }
          
          self.loadRecipeImage(from: data.image)
      
          
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
  let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
  navigationItem.rightBarButtonItem = doneButton
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  private func configureLayoutUI() {
    let padding: CGFloat = 20
    let itemViews = [recipeImageView, recipeTitleLabel, veganLabel, vegetarianLabel, glutenFreeLabel, dairyFreeLabel]
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
      
      veganLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      veganLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      veganLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      
      vegetarianLabel.topAnchor.constraint(equalTo: veganLabel.bottomAnchor),
      vegetarianLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      vegetarianLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      
      glutenFreeLabel.topAnchor.constraint(equalTo: vegetarianLabel.bottomAnchor),
      glutenFreeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      glutenFreeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      
      dairyFreeLabel.topAnchor.constraint(equalTo: glutenFreeLabel.bottomAnchor),
      dairyFreeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      dairyFreeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)

    ])
  }
}
