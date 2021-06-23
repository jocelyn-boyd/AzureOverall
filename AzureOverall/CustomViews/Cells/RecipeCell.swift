//
//  RecipeCell.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import SnapKit

fileprivate enum BookmarkStatus {
	case filled
	case unfilled
}

class RecipeCell: UICollectionViewCell {
	
	//MARK: Properties
	static let reuseIdentifier = String(describing: RecipeCell.self)
	private var bookmarkStatus: BookmarkStatus = .unfilled
	
	private let recipeImageView = RBFoodImageView()
	private let bookmarkButton = RBBookmarkButton()
	private let recipeTitleLabel = RBTitleLabel(textAlignment: .left, fontSize: 18)
	private let prepTimeLabel = RBSubheadingLabel(textAlignment: .left, fontSize: 15)
	private let servingsLabel = RBSecondaryTitleLabel(textAlignment: .left, fontSize: 13)
	
	// MARK: Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Methods
	func setRecipeCell(with recipe: Recipe) {
		recipeTitleLabel.text = recipe.title
		recipeTitleLabel.numberOfLines = 2
		recipeTitleLabel.lineBreakMode = .byTruncatingTail
		
		prepTimeLabel.text = "\(recipe.readyInMinutes.description) Mins Prep"
		servingsLabel.text = "\(recipe.servings.description) serving(s)"
		recipeImageView.downloadImage(fromURL: recipe.id)
	}
	
	private func configure() {
		let padding: CGFloat = 5
		let itemViews = [recipeImageView, recipeTitleLabel, prepTimeLabel, servingsLabel, bookmarkButton]
		for itemView in itemViews { contentView.addSubview(itemView) }
		bookmarkButton.addTarget(self, action: #selector(favButtonPressed), for: .touchUpInside)
		
		
		bookmarkButton.snp.makeConstraints { make in
			make.top.equalTo(recipeImageView.snp.top).offset(padding)
			make.trailing.equalTo(recipeImageView.snp.trailing).offset(-padding)
		}
		
		recipeImageView.snp.makeConstraints { make in
			make.top.equalTo(contentView.snp.top)
			make.leading.equalTo(contentView.snp.leading)
			make.trailing.equalTo(contentView.snp.trailing)
			make.bottom.equalTo(recipeTitleLabel.snp.top)
		}
		
		recipeTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(contentView.snp.leading)
			make.trailing.equalTo(contentView.snp.trailing)
			make.bottom.equalTo(prepTimeLabel.snp.top)
		}
		
		// MARK: TODO: Put labes into a horizontal stackView with equal spacing
		prepTimeLabel.snp.makeConstraints { make in
			make.leading.equalTo(contentView.snp.leading).offset(padding)
			make.bottom.equalTo(contentView.snp.bottom)
		}
		
		servingsLabel.snp.makeConstraints { make in
			make.trailing.equalTo(contentView.snp.trailing).offset(-padding)
			make.bottom.equalTo(contentView.snp.bottom)
		}
	}
	
	private func fillBookmark() {
		let imageConfig = UIImage.SymbolConfiguration(scale: .large)
		let bookmark = UIImage(systemName: "bookmark.fill", withConfiguration: imageConfig)
		bookmarkButton.setImage(bookmark, for: .normal)
		bookmarkStatus = .filled
	}
	
	private func unfillBookmark() {
		let imageConfig = UIImage.SymbolConfiguration(scale: .large)
		let bookmark = UIImage(systemName: "bookmark", withConfiguration: imageConfig)
		bookmarkButton.setImage(bookmark, for: .normal)
		bookmarkStatus = .unfilled
	}
	
	// MARK: @objc Methods
	@objc private func favButtonPressed(sender: UIButton) {
		switch bookmarkStatus {
		case .unfilled:
			fillBookmark()
		case .filled:
			unfillBookmark()
		}
	}
}
