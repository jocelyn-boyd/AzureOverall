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
  
  lazy var dishImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .darkGray
    return imageView
  }()
  
  lazy var recipeTitleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.backgroundColor = .cyan
    return label
  }()
  
  lazy var prepTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "Prep Time"
    label.backgroundColor = .blue
    return label
  }()
  
  lazy var servingsLabel: UILabel = {
    let label = UILabel()
    label.text = "Servings"
    label.backgroundColor = .brown
    label.textAlignment = .right
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .purple
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func configure() {
    addSubview(recipeTitleLabel)
    addSubview(dishImageView)
    addSubview(prepTimeLabel)
    addSubview(servingsLabel)
    
    dishImageView.translatesAutoresizingMaskIntoConstraints = false
    recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    prepTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    servingsLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      
      recipeTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      recipeTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      recipeTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      recipeTitleLabel.bottomAnchor.constraint(equalTo: dishImageView.topAnchor),
      
      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
      dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dishImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
      
      prepTimeLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),
      prepTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      prepTimeLabel.trailingAnchor.constraint(equalTo: servingsLabel.leadingAnchor),
      prepTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      prepTimeLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 2),
      
      servingsLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),
      servingsLabel.leadingAnchor.constraint(equalTo: prepTimeLabel.trailingAnchor),
      servingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      servingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      

    ])
  }
}
