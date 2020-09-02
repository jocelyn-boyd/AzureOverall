//
//  DetailViewController.swift
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var recipe: Recipe?
  var recipeInformation = [RecipeInformation]()
  
  // MARK: UI Properties
  let recipeTitleLabel = AOTitleLabel(textAlignment: .center, fontSize: 20)
  let recipeImageView = AOFoodImageView()
  
  let veganLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let vegetarianLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let glutenFreeLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  let dairyFreeLabel = AOBodyLabel(textAlignment: .left, fontSize: 18)
  
  let sourceNameLabel = AOBodyLabel(textAlignment: .right, fontSize: 20)
  let sourceURLButton = AOButton(backgroundColor: Constants.AppColorPalette.uaRed, title: "Go To Instructions")
  
  // MARK: - Private Properties
  private let padding: CGFloat = 20
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    configureViewController()
    configureUIElements()
    configureRecipeTitleLabel()
    configureRecipeImageView()
    configureDietaryStackViewOne()
    configureDietaryStackViewTwo()
    configureSourceUIElements()
    loadSingleRecipeDetails()
  }
  
  // MARK: - Private Methods
  private func loadRecipeDetails(from recipeInfo: RecipeInformation) {
    recipeTitleLabel.text = recipeInfo.title
    sourceNameLabel.text = "Source: \(recipeInfo.sourceName ?? "")"
    recipeImageView.downloadImage(fromURL: recipeInfo.id)
  }
  
  private func loadDietaryDetails(from dietInfo: RecipeInformation) {
    if dietInfo.vegan {
      veganLabel.text = "✅ Vegan"
    } else {
      veganLabel.text = "❎ Vegan"
    }
    
    if dietInfo.vegetarian {
      vegetarianLabel.text = "✅ Vegetarian"
    } else {
      vegetarianLabel.text = "❎ Vegetarian"
    }
    
    if dietInfo.glutenFree {
      glutenFreeLabel.text = "✅ Gluten Free"
    } else {
      glutenFreeLabel.text = "❎ Gluten Free"
    }
    
    if dietInfo.dairyFree {
      dairyFreeLabel.text = "✅ Dairy Free"
    } else {
      dairyFreeLabel.text = "❎ Dairy Free"
    }
  }
  
  private func loadSingleRecipeDetails() {
    guard let recipe = recipe else { return }
    RecipeFetchingService.manager.fetchSingleRecipe(from: recipe.id) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(data):
          self.loadRecipeDetails(from: data)
          self.loadDietaryDetails(from: data)
        case let .failure(error):
          print(error)
        }
      }
    }
  }
  
  private func addSubviews() {
    let itemViews = [recipeImageView, recipeTitleLabel, veganLabel, vegetarianLabel, glutenFreeLabel, dairyFreeLabel, sourceNameLabel, sourceURLButton]
    for itemView in itemViews { view.addSubview(itemView) }
  }
  
  // MARK: - Configuration Methods
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetailVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  private func configureUIElements() {
    recipeTitleLabel.numberOfLines = 0
    sourceNameLabel.textColor = Constants.AppColorPalette.richBlackFOGRA39
  }
  
  func configureRecipeTitleLabel() {
    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: -padding)
    ])
  }
  
  func configureRecipeImageView() {
    NSLayoutConstraint.activate([
      recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      recipeImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  func configureSourceUIElements() {
    NSLayoutConstraint.activate([
      sourceNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      sourceNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      sourceNameLabel.bottomAnchor.constraint(equalTo: sourceURLButton.topAnchor, constant: -padding),
      
      sourceURLButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      sourceURLButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      sourceURLButton.widthAnchor.constraint(equalToConstant: 250)
    ])
  }
  
  func configureDietaryStackViewOne() {
    let stackView = UIStackView(arrangedSubviews: [veganLabel, vegetarianLabel])
    stackView.axis = .horizontal
    stackView.spacing = 50
    stackView.distribution = .fillEqually
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
    ])
  }
  
  func configureDietaryStackViewTwo() {
    let stackView = UIStackView(arrangedSubviews: [glutenFreeLabel, dairyFreeLabel])
    stackView.axis = .horizontal
    stackView.spacing = 50
    stackView.distribution = .fillEqually
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: veganLabel.bottomAnchor, constant: padding / 2),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
    ])
  }
  
  // MARK: - @objc Methods
   @objc func dismissDetailVC() {
     dismiss(animated: true)
   }
}
