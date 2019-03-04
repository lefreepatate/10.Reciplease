//
//  FavoritesTestCase.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 01/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
@testable import Reciplease
class RecipeServiceTestCase: XCTestCase {
   var ingredient = Ingredients()
   let success = Bool()
   func testGivenIngredientsIsEmptyWhenAddingIngredientThenIngredientHave1More() {
      // Given
      
      ingredient.name = "tomatoe"
      // When
      RecipeService.shared.addIngredient(ingredient: ingredient)
      // Then
      XCTAssertEqual(ingredient.name, "tomatoe")
   }
   let expectation = XCTestExpectation(description: "Wait for queue change.")
   func testRecipeSession() {
      // Given
      var recipes = [[String: Any]]()
      let recipeService = RecipeService.shared
      ingredient.name = "tomatoe"
      recipeService.addIngredient(ingredient: ingredient)
      recipeService.getRecipes { (response, error) in         
         if let response = response  {
            recipes = response
            XCTAssertNotNil(response)
         }
         // Then
         
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 2.0)
   }
   func testRecipeDetailSession() {
      // Given
      let detailRecipe = DetailRecipeService.shared
      detailRecipe.getDetail(with: "Tomato-Basil-Mozzarella-Salad-2657434") { (response, error) in
         if let response = response  {
            XCTAssertNotNil(response)
         } else if let error = error {
            print(error)
         }
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 2.0)
   }
}
