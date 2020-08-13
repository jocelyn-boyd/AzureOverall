//
//  RecipeInformation.swift
//  AzureOverall
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

struct RecipeInformation: Codable {
  let vegetarian: Bool
  let vegan: Bool
  let glutenFree: Bool
  let dairyFree: Bool
  
  let id: Int
  let preparationMinutes: Int?
  let cookingMinutes: Int?
  let title: String
  let readyInMinutes: Int
  let servings: Int
  let sourceName: String?
  let sourceUrl: String?
  let image: String?
  let dishTypes: [String]
  let cuisines: [String]
  let diets: [String]?
  let instructions: String?

  let extendedIngredients: [Ingredients]
  let winePairing: WinePairing
  
  static func getDetailedInformation(from JSONData: Data) throws -> RecipeInformation {
    do {
      let recipeInformation = try JSONDecoder().decode(RecipeInformation.self, from: JSONData)
     return recipeInformation
    } catch {
      throw NetworkError.unableToDecodeJSON(error)
    }
  }
}

struct Ingredients: Codable {
  let name: String
  let originalString: String
}

struct WinePairing: Codable {
  let pairedWines: [String]?
  let pairingText: String?
}
