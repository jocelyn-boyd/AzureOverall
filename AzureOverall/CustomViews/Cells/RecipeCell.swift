//
//  RecipeCell.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
  
  //MARK: - Properties and Initializers
  static let reuseIdentifier = String(describing: RecipeCell.self)
  
  let recipeImageView = AOImageView()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .left, fontSize: 20, numberOfLines: 1)
  let prepTimeLabel = AOSubheadingLabel(textAlignment: .left, fontSize: 18)
  let servingsLabel = AOSecondaryTitleLabel(textAlignment: .left, fontSize: 18)
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Private Methods
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
