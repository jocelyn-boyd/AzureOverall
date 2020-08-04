//
//  File.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/24/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

class RecipeFetchingService {
  
  // MARK: - Static Properties
  static let manager = RecipeFetchingService()
  
  
  // MARK: - Private Properties and Initializers
  private let baseURL = "https://api.spoonacular.com/recipes/"
  private init() {}
  

  //MARK: - Internal Methods
  func getAllRecipes(from query:String, completionHandler: @escaping (Result<[Recipe],RecipeError>) -> Void) {
    
    let endpoint = baseURL + "search?query=\(query.lowercased())&apiKey=\(Secret.apiKey.rawValue)"
    
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
  
  
  func getSingleRecipe(from id: Int, completionHandler: @escaping (Result<RecipeInformation,RecipeError>) -> Void) {
    
    let endpoint = baseURL + "\(id)/information?apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeInformation.getDetailedInformation(from: data)
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
