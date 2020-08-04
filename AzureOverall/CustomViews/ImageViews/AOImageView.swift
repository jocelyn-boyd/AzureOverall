//
//  AOImageView.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/3/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOImageView: UIImageView {
  
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
