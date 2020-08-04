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
  
  
  convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, numberOfLines: Int) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    self.numberOfLines = numberOfLines
  }
  
  
  func configure() {
    textColor = UIColor(displayP3Red: 12 / 255, green: 9 / 255, blue: 13 / 255, alpha: 1)
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
