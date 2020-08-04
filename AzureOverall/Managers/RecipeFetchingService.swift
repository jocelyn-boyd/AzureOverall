//
//  RecipeFetchingService.swift
//  AzureOverall
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
  func getAllRecipes(from query:String, completionHandler: @escaping (Result<[Recipe],NetworkError>) -> Void) {
    
    let endpoint = baseURL + "search?query=\(query.lowercased())&apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeWrapper.getAllRecipes(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.unableToDecodeJSON))
          print(error.localizedDescription)
        }
       
      case let .failure(error):
        completionHandler(.failure(.unableToDecodeJSON))
        print(error.localizedDescription)
      }
    }
  }
  
  
  func getSingleRecipe(from id: Int, completionHandler: @escaping (Result<RecipeInformation,NetworkError>) -> Void) {
    
    let endpoint = baseURL + "\(id)/information?apiKey=\(Secret.apiKey.rawValue)"
    
    NetworkHelper.manager.getData(from: endpoint) { (result) in
      switch result {
      case let .success(data):
        do {
          let recipe = try RecipeInformation.getDetailedInformation(from: data)
          completionHandler(.success(recipe))
        } catch {
          completionHandler(.failure(.unableToDecodeJSON))
        }
       
      case .failure:
        completionHandler(.failure(.unableToComplete))
      }
    }
  }
}
