//
//  DetailViewController.swift
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  // MARK: Properties
  var recipe: Recipe?
  var recipeInformation = [RecipeInformation]()
  
  let recipeImageView = AOFoodImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20)
  let veganLabel = AOSubheadingLabel(textAlignment: .center, fontSize: 18)
  let vegetarianLabel = AOSubheadingLabel(textAlignment: .center, fontSize: 18)
  let glutenFreeLabel = AOSubheadingLabel(textAlignment: .center, fontSize: 18)
  let dairyFreeLabel = AOSubheadingLabel(textAlignment: .center, fontSize: 18)
  
  
  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureLayoutUI()
    loadSingleRecipeDetails()
  }
  
  
  // MARK: Private Methods
  private func loadSingleRecipeDetails() {
    guard let recipe = recipe else { return }
    recipeTitleLabel.text = recipe.title
    recipeTitleLabel.numberOfLines = 0
    
    recipeImageView.downloadImage(fromURL: recipe.id)
    
    RecipeFetchingService.manager.fetchSingleRecipe(from: recipe.id) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(data):
          
          // TODO: Refactor this code
          if data.vegan == false {
            self.veganLabel.text = "Not Vegan"
          } else {
            self.veganLabel.text = "Is Vegan"
          }
          
          if data.vegetarian == false {
            self.vegetarianLabel.text = "Not Vegetarian"
          } else {
            self.vegetarianLabel.text = "Is Vegetarian"
          }
          
          if data.glutenFree == false {
            self.glutenFreeLabel.text = "Not Gluten Free"
          } else {
            self.glutenFreeLabel.text = "Is Gluten Free"
          }
          
          if data.dairyFree == false {
            self.dairyFreeLabel.text = "Not Dairy Free"
          } else {
            self.dairyFreeLabel.text = "Is Dairy Free"
          }
          
        case let .failure(error):
          print(error)
        }
      }
    }
  }
  
  
  // MARK: Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  
  private func configureLayoutUI() {
    let padding: CGFloat = 20
    
    let itemViews = [recipeImageView, recipeTitleLabel, veganLabel, vegetarianLabel, glutenFreeLabel, dairyFreeLabel]
    for itemView in itemViews { view.addSubview(itemView) }
    
    let itemLabels = [veganLabel, vegetarianLabel, glutenFreeLabel, dairyFreeLabel]
    for labels in itemLabels {
      labels.layer.borderColor = Constants.AppColorPalette.richBlackFOGRA39.cgColor
      labels.layer.borderWidth = 1
      labels.layer.cornerRadius = 10
    }
    
    
    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: -padding),
      
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeImageView.heightAnchor.constraint(equalToConstant: 200),
      
      veganLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: padding),
      veganLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      veganLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.3),
      
      glutenFreeLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: padding),
      glutenFreeLabel.leadingAnchor.constraint(equalTo: veganLabel.trailingAnchor),
      glutenFreeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      
      vegetarianLabel.topAnchor.constraint(equalTo: veganLabel.bottomAnchor, constant: padding / 3),
      vegetarianLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      vegetarianLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.3),
      
      dairyFreeLabel.topAnchor.constraint(equalTo: glutenFreeLabel.bottomAnchor, constant: padding / 3),
      dairyFreeLabel.leadingAnchor.constraint(equalTo: vegetarianLabel.trailingAnchor),
      dairyFreeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
    ])
  }
  
  
  // MARK: @objc Methods
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
