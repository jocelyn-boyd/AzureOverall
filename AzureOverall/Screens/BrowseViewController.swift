//
//  BrowseViewController.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/16/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
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
    cv.backgroundColor = UIColor.systemPink
    return cv
  }()
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Int>!

  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.green
      constrainUIElements()
      configureDataSource()
    }
    
  
  func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.9))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350.0))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: recipeCollectionView) { (collectionView, indexPath, number) -> UICollectionViewCell? in
      guard let cell = self.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {return UICollectionViewCell() }
      
      cell.recipeTitleLabel.text = number.description
      return cell
    }
    
   var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(Array(1...10))
    dataSource.apply(initialSnapshot, animatingDifferences: true)
  }
  
  
  func constrainUIElements() {
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
      recipeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
