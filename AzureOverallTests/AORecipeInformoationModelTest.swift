//
//  AORecipeInformoationModelTest.swift
//  AzureOverallTests
//
//  Created by Jocelyn Boyd on 8/3/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import XCTest
@testable import Recipe_Box

class AORecipeInformoationModelTest: XCTestCase {

  private func getRecipeInformationFromJSONData() -> Data {
       guard let pathToData = Bundle.main.path(forResource: "RecipeInformation", ofType: "json") else {
         fatalError("RecipeInformation.json file not found")
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
       let recipeData = getRecipeInformationFromJSONData()
       
       //Act
      var sampleRecipe: RecipeInformation?
      
      do {
        sampleRecipe = try RecipeInformation.getDetailedInformation(from: recipeData)
      } catch {
        print(error)
      }
     
      XCTAssertNotNil(sampleRecipe)
       
       //Assert
       
     }
}
