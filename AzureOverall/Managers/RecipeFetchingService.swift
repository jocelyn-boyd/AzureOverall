//
//  RecipeFetchingService.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import UIKit

class RecipeFetchingService {
  
  // MARK: - Static Properties
  static let manager = RecipeFetchingService()
  
  
  // MARK: - Private Properties and Initializers
  private let baseURL = "https://api.spoonacular.com/recipes/"
  private init() {}
  

  //MARK: - Internal Methods
  func fetchAllRecipes(from query: String, completionHandler: @escaping (Result<[Recipe],NetworkError>) -> Void) {
    
    let endpoint = baseURL + "search?query=\(query.lowercased())&apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkManager.shared.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeWrapper.getAllRecipes(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.unableToDecodeJSON(error)))
          print(error.localizedDescription)
        }
       
      case let .failure(error):
        completionHandler(.failure(.unableToDecodeJSON(error)))
        print(error.localizedDescription)
      }
    }
  }
  
  
  func fetchSingleRecipe(from recipeId: Int, completionHandler: @escaping (Result<RecipeInformation,NetworkError>) -> Void) {
    
    let endpoint = baseURL + "\(recipeId)/information?apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkManager.shared.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeInformation.getDetailedInformation(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.unableToDecodeJSON(error)))
        }
       
      case .failure:
        completionHandler(.failure(.unableToComplete))
      }
    }
  }
}
