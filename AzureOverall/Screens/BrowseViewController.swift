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
  
  
  // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
      configureBackground()
      constrainUIElements()
      configureDataSource()
      loadData()
    }
  
  
  // MARK: - Private Methods
  private func configureBackground() { view.backgroundColor = .systemBackground }
  
  
  private func loadData() {
    RecipeFetchingService.manager.getAllRecipes(from: "burger") { [weak self] (result) in
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
          print(error)
        }
      }
    }
  }
  
  
 private func configurePortraitLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
    
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
      cell.prepTimeLabel.text = "\(cellData.readyInMinutes.description) Mins Prep"
      cell.servingsLabel.text = "For \(cellData.servings.description) People"
      
            
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
     dataSource?.apply(snapshot, animatingDifferences: true)
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

extension BrowseViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedRecipe = recipes[indexPath.row]
    let detailVC = DetailViewController()
    detailVC.recipeDetails = selectedRecipe
    present(detailVC, animated: true)
  }
  
 
  
  
}
