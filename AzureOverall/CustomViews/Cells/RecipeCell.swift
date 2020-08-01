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
  
  lazy var recipeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .darkGray
    imageView.contentMode = .scaleToFill
    return imageView
  }()
  
  lazy var recipeTitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.backgroundColor = .cyan
    label.layer.borderColor = UIColor.blue.cgColor
    label.layer.borderWidth = 1
    return label
  }()
  
  lazy var prepTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "Prep Time: 30 mins"
    label.backgroundColor = .brown
    label.textAlignment = .center
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.borderWidth = 1
    return label
  }()
  
  lazy var servingsLabel: UILabel = {
    let label = UILabel()
    label.text = "Servings: 4"
    label.backgroundColor = .brown
    label.textAlignment = .right
    label.textAlignment = .center
    label.layer.borderColor = UIColor.black.cgColor
    label.layer.borderWidth = 1
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
    recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    prepTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    servingsLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor),
      recipeTitleLabel.heightAnchor.constraint(equalToConstant: 40),
      
      recipeImageView.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor),
      recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      recipeImageView.bottomAnchor.constraint(equalTo: prepTimeLabel.topAnchor),
      
      prepTimeLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      prepTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      prepTimeLabel.trailingAnchor.constraint(equalTo: servingsLabel.leadingAnchor),
      prepTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      prepTimeLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 2),
      prepTimeLabel.heightAnchor.constraint(equalToConstant: 40),

      servingsLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
      servingsLabel.leadingAnchor.constraint(equalTo: prepTimeLabel.trailingAnchor),
      servingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      servingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
