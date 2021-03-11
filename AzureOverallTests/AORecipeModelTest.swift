//
//  AzureOverallTests.swift
//  AzureOverallTests
//
//  Created by Jocelyn Boyd on 7/16/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import XCTest
@testable import Recipe_Box

class AORecipeModelTest: XCTestCase {
  
  private func getTestRecipeJSONData() -> Data {
    guard let pathToData = Bundle.main.path(forResource: "Recipes", ofType: "json") else {
      fatalError("Recipes.json file not found")
    }
    
    let internalUrl = URL(fileURLWithPath: pathToData)
    
    do {
      let data = try Data(contentsOf: internalUrl)
      return data
    } catch  {
      fatalError("An error occured: \(error)")
    }
  }
  
  func testLoadRecipes() {
    //Arrange
    let recipeData = getTestRecipeJSONData()
    
    //Act
    var sampleRecipes = [Recipe]()
    
    do {
      sampleRecipes = try RecipeWrapper.getAllRecipes(from: recipeData)
      print(sampleRecipes)
    } catch {
      print(error)
    }
    
    //Assert
    XCTAssertTrue(sampleRecipes.count != 0, "There are \(sampleRecipes.count) recipes found.")
  }
}
