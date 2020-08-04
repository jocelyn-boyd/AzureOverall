//
//  RecipeCell.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/17/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: RecipeCell.self)
  let recipeTitleLabel = TitleLabel(textAlignment: .left, fontSize: 20)
  let prepTimeLabel = SubheadingLabel(textAlignment: .left, fontSize: 18)
  
  lazy var recipeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  
  lazy var servingsLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .subheadline), size: 18)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBackground
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func configure() {
    addSubview(recipeTitleLabel)
    addSubview(recipeImageView)
    addSubview(prepTimeLabel)
    addSubview(servingsLabel)
    
    recipeImageView.translatesAutoresizingMaskIntoConstraints = false
    servingsLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let padding: CGFloat = 20
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
      prepTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
      
      servingsLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      servingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      servingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
    ])
  }
}
