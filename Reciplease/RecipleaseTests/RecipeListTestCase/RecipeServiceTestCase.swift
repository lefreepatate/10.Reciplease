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
   var allergie = Allergies()
   var recipes: [Match]!
   var recipeService: RecipeService!
   
   let expectation = XCTestExpectation(description: "Wait for queue change")
   override func setUp() {
      super.setUp()
      recipeService = RecipeService()
   }
   
   func getRecipesSession(data sessionData: Foundation.Data?, response: HTTPURLResponse?, error: Error?){
      recipeService = RecipeService(FakeNetworkRequest(data: sessionData, response: response, error: error))
      self.expectation.fulfill()
   }
   
   func testGivenIngredientsIsEmptyWhenAddingIngredientThenIngredientHave1More() {
      // Given
      ingredient.name = "tomatoe"
      // When
      recipeService.ingredientsArray.append(ingredient)
      // Then
      XCTAssertEqual(recipeService.ingredientsArray.count, 1)
   }
   func testGivenAllergiesIsEmptyWhenAddingAllergyThenAllergiesHave1More() {
      // Given
      allergie.name = "Dairy"
      // When
      recipeService.allergiesArray.append(allergie)
      // Then
      XCTAssertEqual(allergie.name, "Dairy")
   }
   func testRecipeServiceShouldPostFailedCallbackIfError() {
      // Given
      ingredient.name = "tomatoe"
      recipeService.ingredientsArray.append(ingredient)
      
      getRecipesSession(data: nil, response: nil, error: FakeListResponseData.error)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldPostFailedCallbackIfNoData() {
      // Given
      ingredient.name = "tomatoe"
      recipeService.ingredientsArray.append(ingredient)
      
      getRecipesSession(data: nil, response: nil, error: nil)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldPostFailedCallbackIfIncorrectResponse() {
      // Given
      getRecipesSession(data: FakeListResponseData.incorrectRecipeData,
                        response: FakeListResponseData.responseOK, error: nil)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldSuccessCallbackIfCorrectData() {
      // Given
      getRecipesSession(data: FakeListResponseData.recipeCorrectData, response: FakeListResponseData.responseOK, error: nil)
      recipeService.getRecipes { (recipes, error) in
         XCTAssertNotNil(recipes)
      }
      wait(for: [expectation], timeout: 0.05)
   }
   func testRecipeServiceShouldSuccessCallbackResponseEqualsTrue() {
      // Given
      getRecipesSession(data: FakeListResponseData.recipeCorrectData, response: FakeListResponseData.responseOK, error: nil)      
      recipeService.getRecipes { (response, error) in
         XCTAssertNotNil(response)
         XCTAssertNil(error)
         XCTAssertEqual(response!.matches![0].sourceDisplayName, "A Sweet double test")
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 0.05)
   }
   func testGivenAllergiesShouldsuccessCallbackCorrectData() {
      // Given
      getRecipesSession(data: FakeListResponseData.recipeAllergyCorrectData, response: FakeListResponseData.responseOK, error: nil)
      recipeService.getRecipes { (response, error) in
         XCTAssertNotNil(response)
         XCTAssertNil(error)
         XCTAssertEqual(response!.matches![0].sourceDisplayName, "A Sweet Allergy Test")
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 0.05)
   }
}
