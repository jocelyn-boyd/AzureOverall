//
//  AOFavoriteBUtton.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/28/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AOBookmarkButton: UIButton {

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 10
    contentEdgeInsets = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
    backgroundColor = UIColor(red: 83 / 255, green: 179 / 255, blue: 203 / 255, alpha: 0.4)
    tintColor = .white
    
    let imageConfig = UIImage.SymbolConfiguration(scale: .large)
    setImage(UIImage(systemName: "bookmark", withConfiguration: imageConfig), for: .normal)
    addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
    
  }
  
  @objc private func favButtonPressed() {
    
  }

}
