//
//  DetailViewController.swift
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties  & UI Elements
    private let recipe: Recipe
    private var recipeInformation = [RecipeInformation]()
    
    // MARK: UI elements
    private let recipeTitleLabel = RBTitleLabel(textAlignment: .center, fontSize: 20)
    private let recipeImageView = RBFoodImageView()
    
    // Recfactor into a collectionView
    private let veganLabel = RBBodyLabel(textAlignment: .left, fontSize: 18)
    private let vegetarianLabel = RBBodyLabel(textAlignment: .left, fontSize: 18)
    private let glutenFreeLabel = RBBodyLabel(textAlignment: .left, fontSize: 18)
    private let dairyFreeLabel = RBBodyLabel(textAlignment: .left, fontSize: 18)
    
    private let sourceNameLabel = RBBodyLabel(textAlignment: .right, fontSize: 20)
    private let sourceURLButton = RBButton(backgroundColor: Constants.AppColorPalette.uaRed, title: "Go To Instructions")
    
    private let padding: CGFloat = 20
    
    // MARK: Initializers
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureViewController()
        configureUIElements()
        configureRecipeTitleLabel()
        configureRecipeImageView()
        configureDietaryStackViewOne()
        configureDietaryStackViewTwo()
        configureSourceUIElements()
        loadSingleRecipeDetails()
    }
    
    // MARK: - Private Methods
    private func loadRecipeDetails(from recipeInfo: RecipeInformation) {
        recipeTitleLabel.text = recipeInfo.title
        sourceNameLabel.text = "Source: \(recipeInfo.sourceName ?? "Name Unavailable")"
        recipeImageView.downloadImage(fromURL: recipeInfo.id)
    }
    
    
    //TODO: Refactor Bug
    private func loadDietaryDetails(from dietInfo: RecipeInformation) {
        veganLabel.text = dietInfo.stringifyDiets
    }
    
    private func loadSingleRecipeDetails() {
        RecipeFetchingService.manager.fetchSingleRecipe(from: recipe.id) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self.loadRecipeDetails(from: data)
                    self.loadDietaryDetails(from: data)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    private func addSubviews() {
        let itemViews = [recipeImageView, recipeTitleLabel, veganLabel, vegetarianLabel, glutenFreeLabel, dairyFreeLabel, sourceNameLabel, sourceURLButton]
        for itemView in itemViews { view.addSubview(itemView) }
    }
    
    // MARK: - Configuration Methods
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetailVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureUIElements() {
        recipeTitleLabel.numberOfLines = 0
        sourceNameLabel.textColor = Constants.AppColorPalette.richBlackFOGRA39
    }
    
    private func configureRecipeTitleLabel() {
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: -padding)
        ])
    }
    
    private func configureRecipeImageView() {
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureSourceUIElements() {
        NSLayoutConstraint.activate([
            sourceNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sourceNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            sourceNameLabel.bottomAnchor.constraint(equalTo: sourceURLButton.topAnchor, constant: -padding),
            
            sourceURLButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            sourceURLButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sourceURLButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // TODO: Refactor into collectionView cells, UICollectionViewCompositionalLayout
    private func configureDietaryStackViewOne() {
        let stackView = UIStackView(arrangedSubviews: [veganLabel, vegetarianLabel])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureDietaryStackViewTwo() {
        let stackView = UIStackView(arrangedSubviews: [glutenFreeLabel, dairyFreeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: veganLabel.bottomAnchor, constant: padding / 2),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    // MARK: - @objc Methods
    @objc private func dismissDetailVC() {
        dismiss(animated: true)
    }
}
