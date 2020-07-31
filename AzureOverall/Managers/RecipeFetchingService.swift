//
//  File.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 7/24/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

class RecipeFetchingService {
  private init() {}
  static let manager = RecipeFetchingService()
  
  func getRecipes() -> [Recipe] {
    guard let pathToData = Bundle.main.path(forResource: "Recipes", ofType: "json") else {
      fatalError("Recipes.json not found")
    }
    let internalURL = URL(fileURLWithPath: pathToData)
    
    do {
      let data = try Data(contentsOf: internalURL)
      return try RecipeWrapper.getallRecipes(from: data)
    } catch {
      fatalError("Error reading data")
    }
  }
}
