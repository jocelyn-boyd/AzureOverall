//
//  AOTextField.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/29/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOTextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(placeholder: String) {
    self.init(frame: .zero)
    self.placeholder = placeholder
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false

    layer.cornerRadius           = 15
    borderStyle = .roundedRect

    textColor                     = .label
    tintColor                     = Constants.AppColorPalette.uaRed
    textAlignment                 = .left
    font                          = UIFont.preferredFont(forTextStyle: .title2)

    backgroundColor               = .tertiarySystemBackground
    autocorrectionType            = .no
    clearButtonMode               = .whileEditing
  }

}
