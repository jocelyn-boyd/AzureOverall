//
//  AOButton.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
    configure()
  }
  
  func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 15
  }
}
