//
//  RecipeInformation.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 8/3/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation

enum JSONError: Error {
  case decodingError(Error)
}

struct RecipeInformation: Codable {
  let vegetarian: Bool
  let vegan: Bool
  let dairyFree: Bool
  
  let preparationMinutes: Int
  let cookingMinutes: Int
  let sourceName: String
  let extendedIngredients: [Ingredients]
  let id: Int
  let title: String
  let readyInMinutes: Int
  let servings: Int
  let sourceURL: String
  let image: String
  let summary: String
  let cuisines: [String]
  let dishTypes: [String]
  let wineParing: [WinePairing]
  let instructions: String
  let analyzedInstructions: [AnalyzedInstructions]
  
  static func getDetailedInformation(from JSONData: Data) throws -> RecipeInformation {
    do {
      let recipeInformation = try JSONDecoder().decode(RecipeInformation.self, from: JSONData)
     return recipeInformation
    } catch {
      throw NetworkError.couldNotDecode
    }
  }
}

struct Ingredients: Codable {
  let id: Int
  let aisle: String
  let name: String
  let originalString: String
}

struct WinePairing: Codable {
  let pairedWine: [String]
  let pairintText: String
}

struct AnalyzedInstructions: Codable {
  let steps: [Steps]
}

struct Steps: Codable {
  let number: Int
  let step: String
}
