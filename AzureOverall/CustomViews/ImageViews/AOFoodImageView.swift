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
    contentMode = .scaleToFill
    layer.cornerRadius = 10
    layer.masksToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }
}
