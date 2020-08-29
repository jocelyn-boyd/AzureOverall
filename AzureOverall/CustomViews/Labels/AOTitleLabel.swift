//
//  AOTitleLabel.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOTitleLabel: UILabel {
  
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
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }
  
  
  func configure() {
    textColor = Constants.Color.richBlackFOGRA39
    numberOfLines = 0
    translatesAutoresizingMaskIntoConstraints = false
  }
}
