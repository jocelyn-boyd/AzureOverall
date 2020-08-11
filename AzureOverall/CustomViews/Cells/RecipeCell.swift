//
//  RecipeCell.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: RecipeCell.self)
  
  let recipeImageView = AOFoodImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .left, fontSize: 18, numberOfLines: 1)
  let prepTimeLabel = AOSubheadingLabel(textAlignment: .left, fontSize: 15)
  let servingsLabel = AOSecondaryTitleLabel(textAlignment: .left, fontSize: 13)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func set(recipes: Recipe) {
    recipeTitleLabel.text = recipes.title
    prepTimeLabel.text = "\(recipes.readyInMinutes.description) Mins Prep"
    servingsLabel.text = "For \(recipes.servings.description) People"
    
    ImageFetchingService.manager.fetchImage(from: recipes.id) { [weak self ](result) in
      guard let _ = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(image):
          self?.recipeImageView.image = image
        case let .failure(error):
          print(error)
        }
      }
    }
  }
  
  private func configure() {
    let padding: CGFloat = 5
    let itemViews = [recipeImageView, recipeTitleLabel, prepTimeLabel, servingsLabel]
    for itemView in itemViews { contentView.addSubview(itemView) }
    
    
    NSLayoutConstraint.activate([
      recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      recipeImageView.bottomAnchor.constraint(equalTo: recipeTitleLabel.topAnchor),
      
      recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: prepTimeLabel.topAnchor),
      
      prepTimeLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      prepTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      prepTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      prepTimeLabel.bottomAnchor.constraint(equalTo: servingsLabel.topAnchor),
      
      servingsLabel.topAnchor.constraint(equalTo: prepTimeLabel.bottomAnchor),
      servingsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      servingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      servingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
