//
//  BrowseViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/16/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
  
  // MARK: - Properties
  enum Section {
    case main
  }
  
  lazy var recipeSearchBar: UISearchBar = {
    let sb = UISearchBar()
    return sb
  }()

  lazy var recipeCollectionView: UICollectionView = {
    let cv = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
    cv.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
    cv.backgroundColor = .systemBackground
    return cv
  }()
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Recipe>!
  
  var recipes = [Recipe]() {
    didSet {
      updateDataSource(with: recipes)
    }
  }
  
  
  // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = .systemBackground
      constrainUIElements()
      configureDataSource()
      loadData()
    }
  
  
  // MARK: - Private Methods
 private func loadData() {
    //    recipes = RecipeFetchingService.manager.getRecipes()
    
    RecipeFetchingService.manager.getRecipes { [weak self] (result) in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        switch result {
        case  let .success(fetchedRecipes):
          self.recipes = fetchedRecipes
        case let .failure(error):
          let alertVC = UIAlertController(title: "Error",
                                          message: "An error fetching recipes occured: \(error.description)",
                                          preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
          self.present(alertVC, animated:  true, completion: nil)
        }
      }
    }
  }
  
  
 private func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350.0))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
 
  
 private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Recipe>(collectionView: recipeCollectionView) { (collectionView, indexPath, recipe) -> UICollectionViewCell? in
      guard let cell = self.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {return UICollectionViewCell() }
      
      let cellData = self.recipes[indexPath.row]
      cell.recipeTitleLabel.text = cellData.title
      cell.prepTimeLabel.text = "Prep Time: \(cellData.readyInMinutes.description) mins"
      cell.servingsLabel.text = "Servings: \(cellData.servings.description)"
      
      ImageFetchingService.manager.getImage(from: cellData.id) { [weak self ](result) in
        guard let _ = self else { return }
        DispatchQueue.main.async {
          switch result {
          case let .success(image):
            cell.recipeImageView.image = image
          case let .failure(error):
            print(error)
          }
        }
      }
      return cell
    }
  }
  
  
 private func updateDataSource(with recipes: [Recipe]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Recipe>()
     snapshot.appendSections([.main])
     snapshot.appendItems(recipes)
     dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  
 private func constrainUIElements() {
    view.addSubview(recipeSearchBar)
    view.addSubview(recipeCollectionView)
    
    recipeSearchBar.translatesAutoresizingMaskIntoConstraints = false
    recipeCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      recipeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      recipeSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      recipeSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      recipeCollectionView.topAnchor.constraint(equalTo: recipeSearchBar.bottomAnchor),
      recipeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      recipeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      recipeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
