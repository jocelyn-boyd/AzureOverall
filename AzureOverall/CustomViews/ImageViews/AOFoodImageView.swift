//
//  AOImageView.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOFoodImageView: UIImageView {
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  convenience init() {
    self.init(frame: .zero)
  }
  
  
  func configure() {
    contentMode = .scaleAspectFill
    layer.cornerRadius = 10
    layer.masksToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func downloadImage(fromURL recipeID: Int) {
    ImageFetchingService.manager.fetchImage(using: recipeID) { [weak self] (result) in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
        case let .success(image):
          self.image = image
        case let .failure(error):
          print(error)
        }
      }
    }
  }
}
