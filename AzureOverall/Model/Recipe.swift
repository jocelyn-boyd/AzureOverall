//
//  Recipe.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

struct RecipeWrapper: Codable, Hashable {
let results: [Recipe]
 
 static func getAllRecipes(from JSONData: Data) throws -> [Recipe] {
   do {
     let recipeWrapper = try JSONDecoder().decode(RecipeWrapper.self, from: JSONData)
    return recipeWrapper.results
   } catch {
    throw NetworkError.unableToDecodeJSON(error)
   }
 }
}

struct Recipe: Codable, Hashable {
  let id: Int
  let title: String
  let readyInMinutes: Int
  let servings: Int
}
