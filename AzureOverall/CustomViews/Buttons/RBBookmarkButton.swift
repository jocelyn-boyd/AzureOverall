//
//  AOFavoriteBUtton.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/28/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RBBookmarkButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		layer.cornerRadius = 10
		contentEdgeInsets = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
		backgroundColor = Constants.AppColorPalette.fireOpalHalfOpacity
		tintColor = .white
		isUserInteractionEnabled = true
		
		let imageConfig = UIImage.SymbolConfiguration(scale: .large)
		setImage(UIImage(systemName: "bookmark", withConfiguration: imageConfig), for: .normal)
	}
}
