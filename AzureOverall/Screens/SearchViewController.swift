//
//  BrowseViewController.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
	// MARK: Private Properties
	private enum Section {
		case main
	}
	private var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>?
	private var recipes = [Recipe]() {
		didSet {
			updateDataSource(with: recipes)
		}
	}
	
	private var searchTerm: String? = "" {
		didSet {
			loadAllRecipesData()
		}
	}
	
	private lazy var recipeSearchBar: UISearchBar = {
		let sb = UISearchBar()
		sb.delegate = self
		sb.autocapitalizationType = .none
		sb.tintColor = .systemBlue
		sb.placeholder = "I'm in the mood for..."
		sb.showsCancelButton = false
		return sb
	}()
	
	private lazy var recipeCollectionView: UICollectionView = {
		let cv = UICollectionView(frame: view.bounds, collectionViewLayout: configurePortraitMode())
		cv.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
		cv.backgroundColor = .systemBackground
		cv.delegate = self
		return cv
	}()
	
	// MARK: - Lifecyle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureViewsAndConstraints()
		configureDataSource()
	}
	
	//MARK: - Networking Methods
	private func loadAllRecipesData() {
		guard let query = searchTerm else { return }
		RecipeFetchingService.manager.fetchAllRecipes(with: query) { [weak self] (result) in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
				case  let .success(allfetchedRecipes):
					self.recipes = allfetchedRecipes
				case .failure:
					// MARK: TODO: Increase limit of API calls to the Spoonacular database
					let alertVC = UIAlertController(title: "Error",
																					message: "An error fetching recipes occured. Your daily points limit of 150 has been reached.",
																					preferredStyle: .alert)
					alertVC.addAction(UIAlertAction(title: "OK", style: .default))
					self.present(alertVC, animated:  true)
				}
			}
		}
	}
	
	// MARK: - DiffableDataSource Methods
	private func configureDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: recipeCollectionView) { (collectionView, indexPath, recipeData) -> UICollectionViewCell? in
			
			guard let cell = self.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {return UICollectionViewCell() }
			
			cell.setRecipeCell(with: recipeData)
			return cell
		}
	}
	
	private func updateDataSource(with recipes: [Recipe]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
		snapshot.appendSections([.main])
		snapshot.appendItems(recipes)
		dataSource?.apply(snapshot, animatingDifferences: true)
	}
	
	// MARK: - Configuration Methods
	private func configureViewController() {
		navigationController?.isNavigationBarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = "Recipe Box"
		view.backgroundColor = .systemBackground
	}
	
	private func configurePortraitMode() -> UICollectionViewCompositionalLayout {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.9))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250.0))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	// MARK: TODO: add configureLandscapeMode method
	
	private func configureViewsAndConstraints() {
		let itemViews = [recipeSearchBar, recipeCollectionView]
		for itemView in itemViews {
			view.addSubview(itemView)
		}
		recipeSearchBar.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview()
		}
		recipeCollectionView.snp.makeConstraints { make in
			make.top.equalTo(recipeSearchBar.snp.bottom)
			make.bottom.leading.trailing.equalToSuperview()
		}
	}
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedRecipe = recipes[indexPath.row]
		let detailVC = DetailViewController(recipe: selectedRecipe)
		let navController = UINavigationController(rootViewController: detailVC)
		present(navController, animated: true)
	}
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = true
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchTerm = searchBar.text ?? nil
		searchBar.showsCancelButton = false
		searchBar.resignFirstResponder()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.endEditing(true)
		searchBar.showsCancelButton = false
		updateDataSource(with: [])
		recipeSearchBar.text = nil
		recipeSearchBar.resignFirstResponder()
	}
}
