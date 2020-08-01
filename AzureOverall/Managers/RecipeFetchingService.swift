//
//  File.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/24/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

class RecipeFetchingService {
  
  // MARK: - Private Properties and Initializers
  
  private let spoonacularEndpoint = "https://api.spoonacular.com/recipes/search?query=burger&apiKey=1a420bde95ca45129efe876a679e501b"
  
  private init() {}
  
  // MARK: - Static Properties
  
  static let manager = RecipeFetchingService()
  
  //MARK: - Internal Methods
  
  func getRecipes(completionHandler: @escaping (Result<[Recipe],RecipeError>) -> Void) {
    NetworkHelper.manager.getData(from: spoonacularEndpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeWrapper.getAllRecipes(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.jsonDecodingError(error)))
        }
       
      case let .failure(networkHelper):
        completionHandler(.failure(.networkError(networkHelper)))
      }
    }
  }
  
//  func getRecipes() -> [Recipe] {
//    guard let pathToData = Bundle.main.path(forResource: "Recipes", ofType: "json") else {
//      fatalError("Recipes.json not found")
//    }
//    let internalURL = URL(fileURLWithPath: pathToData)
//
//    do {
//      let data = try Data(contentsOf: internalURL)
//      return try RecipeWrapper.getallRecipes(from: data)
//    } catch {
//      fatalError("Error reading data")
//    }
//  }

}
