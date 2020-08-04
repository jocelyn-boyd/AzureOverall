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
  private let baseURL = "https://api.spoonacular.com/recipes/search?query="
  private init() {}
  
  
  // MARK: - Static Properties
  static let manager = RecipeFetchingService()
  
  
  //MARK: - Internal Methods
  func getAllRecipes(from query:String, completionHandler: @escaping (Result<[Recipe],RecipeError>) -> Void) {
    
    let endpoint = baseURL + "\(query)&apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeWrapper.getAllRecipes(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.jsonDecodingError(error)))
          print(error.localizedDescription)
        }
       
      case let .failure(error):
        completionHandler(.failure(.jsonDecodingError(error)))
        print(error.localizedDescription)
      }
    }
  }
  
  
  func getSingleRecipe(from id: Int, completionHandler: @escaping (Result<[Recipe],RecipeError>) -> Void) {
    
    let endpoint = baseURL + "\(id)&apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
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

}
