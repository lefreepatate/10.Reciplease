//
//  RecipeDetailTestCase.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 22/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeDetailTestCase: XCTestCase {
   var detailService: DetailRecipeService!
   var recipe:Detail?
   let expectation = XCTestExpectation(description: "Wait for queue change")
   
   override func setUp() {
      super.setUp()
      detailService = DetailRecipeService()
   }
   
   func getDetailSession(data sessionData: Foundation.Data?, response: HTTPURLResponse?, error: Error?){
      detailService = DetailRecipeService(FakeDetailNetworkRequest(data: sessionData, response: response, error: error))
      self.expectation.fulfill()
   }
   
   func testDetailServiceShouldPostFailedCallbackIfError() {
      // Given
      getDetailSession(data: nil, response: nil, error: FakeListResponseData.error)
      XCTAssertNil(recipe)
   }
   func testRecipeServiceShouldPostFailedCallbackIfNoData() {
      // Given      
      getDetailSession(data: nil, response: nil, error: nil)
      XCTAssertNil(recipe)
   }
   func testRecipeServiceShouldPostFailedCallbackIfIncorrectResponse() {
      // Given
      getDetailSession(data: FakeListResponseData.incorrectRecipeData,
                        response: FakeListResponseData.responseOK, error: nil)
      XCTAssertNil(recipe)
   }
   func testRecipeServiceShouldSuccessCallbackIfCorrectData() {
      // Given
      getDetailSession(data: FakeListResponseData.recipeDetailCorrectData, response: FakeListResponseData.responseOK, error: nil)
      detailService.getDetail(with: "Beef-And-Dried-Tomato-Salad-1445298") { (response, error) in
         XCTAssertNotNil(response)
      }
      wait(for: [expectation], timeout: 0.05)
   }
   func testDetailServiceShouldSuccessCallbackResponseEqualsTrue() {
      // Given
      getDetailSession(data: FakeListResponseData.recipeDetailCorrectData, response: FakeListResponseData.responseOK, error: nil)
      detailService.getDetail(with: "Beef-And-Dried-Tomato-Salad-1445298") { (response, error) in
         XCTAssertNotNil(response)
         XCTAssertNil(error)
         XCTAssertEqual(response?.name, "Beef And Dried Tomato Salad")
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 0.05)
   }
   
}
