//
//  BrowseViewController.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - DiffableDataSource Enum
    enum Section {
        case main
    }
    
    //MARK: - Private Properties
    private lazy var recipeSearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.autocapitalizationType = .none
        sb.layer.borderWidth = 1
        sb.layer.borderColor = UIColor.white.cgColor
        sb.tintColor = Constants.AppColorPalette.uaRed
        sb.placeholder = "search recipes"
        return sb
    }()
    
    private lazy var recipeCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: configurePortraitLayout())
        cv.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        cv.delegate = self
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
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
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureLayoutUI()
        configureDataSource()
    }
    
    //MARK: - Networking Methods
    private func loadAllRecipesData() {
        guard let searchTerm = searchTerm else { return }
        
        RecipeFetchingService.manager.fetchAllRecipes(from: searchTerm) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case  let .success(fetchedRecipes):
                    self.recipes = fetchedRecipes
                case .failure:
                    let alertVC = UIAlertController(title: "Error",
                                                    message: "An error fetching recipes occured. Your daily points limit of 150 has been reached.",
                                                    preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK",
                                                    style: .default,
                                                    handler: nil))
                    self.present(alertVC, animated:  true, completion: nil)
                }
            }
        }
    }
    
    // MARK: - Configuration Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        recipeSearchBar.showsCancelButton = true
        
        // Will not include in MVP. Implement in future versions.
        // let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(profileButtonTapped))
        // navigationItem.rightBarButtonItem = profileButton
        
        let clearButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearButtonPressed))
        navigationItem.rightBarButtonItem = clearButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes"
    }
    
    private func configurePortraitLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureLayoutUI() {
        let itemViews = [recipeSearchBar, recipeCollectionView]
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            recipeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recipeSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipeSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            recipeCollectionView.topAnchor.constraint(equalTo: recipeSearchBar.bottomAnchor),
            recipeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recipeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recipeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
    
    // MARK: - @objc Methods
    //@objc private func profileButtonTapped() {
        //let profileVC = ProfileViewController()
       // let navController = UINavigationController(rootViewController: profileVC)
        //present(navController, animated: true)
    //}
    
    @objc private func clearButtonPressed() {
        updateDataSource(with: [])
        recipeSearchBar.text = nil
        recipeSearchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem?.isEnabled = false
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
        navigationItem.rightBarButtonItem?.isEnabled = true // Clear button
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
    
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        navigationItem.rightBarButtonItem?.isEnabled = false // Clear button
    }
}
