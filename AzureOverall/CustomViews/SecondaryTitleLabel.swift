//
//  SecondarySubheadingLabel.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/3/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class SecondaryTitleLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
  }
  
  
  private func configure() {
    textColor = .secondaryLabel
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints = false
  }
  
}
