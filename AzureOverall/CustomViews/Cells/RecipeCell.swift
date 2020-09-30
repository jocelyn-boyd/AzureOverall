//
//  RecipeCell.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: RecipeCell.self)
  
  enum BookmarkStatus {
    case filled
    case unfilled
  }
  var bookmarkStatus: BookmarkStatus = .unfilled
  var delegate: RecipeFavoriteDelegate?
  
  let recipeImageView = AOFoodImageView()
  let favButton = AOBookmarkButton()
  let recipeTitleLabel = AOTitleLabel(textAlignment: .left, fontSize: 18)
  let prepTimeLabel = AOSubheadingLabel(textAlignment: .left, fontSize: 15)
  let servingsLabel = AOSecondaryTitleLabel(textAlignment: .left, fontSize: 13)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setCell(with recipe: Recipe) {
    recipeTitleLabel.text = recipe.title
    recipeTitleLabel.numberOfLines = 2
    recipeTitleLabel.lineBreakMode = .byTruncatingTail
    
    prepTimeLabel.text = "\(recipe.readyInMinutes.description) Mins Prep"
    servingsLabel.text = "\(recipe.servings.description) serving(s)"
    recipeImageView.downloadImage(fromURL: recipe.id)
  }
  
  private func configure() {
    let padding: CGFloat = 5
    let itemViews = [recipeImageView, recipeTitleLabel, prepTimeLabel, servingsLabel]
    for itemView in itemViews { contentView.addSubview(itemView) }
    
      contentView.addSubview(favButton)
      favButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      favButton.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: padding),
      favButton.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -padding),
      
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
  
    @objc private func favButtonPressed(sender: UIButton) {
      switch bookmarkStatus {
      case .unfilled:
        fillBookmark()
      case .filled:
        unfillBookmark()
      }
    }
  
  func fillBookmark() {
    let imageConfig = UIImage.SymbolConfiguration(scale: .large)
    let bookmark = UIImage(systemName: "bookmark.fill", withConfiguration: imageConfig)
    favButton.setImage(bookmark, for: .normal)
    bookmarkStatus = .filled
  }
  
  func unfillBookmark() {
    let imageConfig = UIImage.SymbolConfiguration(scale: .large)
    let bookmark = UIImage(systemName: "bookmark", withConfiguration: imageConfig)
    favButton.setImage(bookmark, for: .normal)
    bookmarkStatus = .unfilled
  }
}
