//
//  FavoritesTestCase.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 01/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class RecipeServiceTestCase: XCTestCase {
   var ingredient: Ingredients!
   var allergie = Allergies()
   var recipes: [Match]?
   var recipeService:RecipeService!
   var success: Bool!
   let expectation = XCTestExpectation(description: "Wait for queue change")
   
   override func setUp() {
      super.setUp()
      ingredient = Ingredients()
      recipeService = RecipeService()
      success = Bool()
   }
   
   func getRecipesSession(data sessionData: Foundation.Data?, response: URLResponse?, error: Error?){
      recipeService = RecipeService(session: URLSessionFake(data: sessionData, response: response, error: error))
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
      XCTAssertFalse(success)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldPostFailedCallbackIfNoData() {
      // Given
      ingredient.name = "tomatoe"
      recipeService.ingredientsArray.append(ingredient)
      
      getRecipesSession(data: nil, response: nil, error: nil)
      XCTAssertFalse(success)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldPostFailedCallbackIfIncorrectResponse() {
      // Given
      getRecipesSession(data: FakeListResponseData.incorrectRecipeData,
                        response: FakeListResponseData.responseOK, error: nil)
      XCTAssertFalse(success)
      XCTAssertNil(recipes)
   }
   func testRecipeServiceShouldSuccessCallbackIfCorrectData() {
      getRecipesSession(data: FakeListResponseData.recipeCorrectData, response: FakeListResponseData.responseOK, error: nil)
      // Given
      ingredient.name = "Salad Tomatoe, Bacon "
      recipeService.ingredientsArray.append(ingredient)
      recipeService.getRecipes { (response, error) in
         XCTAssertTrue(self.success)
         XCTAssertNotNil(response)
         self.expectation.fulfill()
      }
      self.expectation.fulfill()
   }
}
