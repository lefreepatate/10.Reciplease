//
//  File.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 23/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import XCTest
@testable import Reciplease

class FavoritesTestCase: XCTestCase {
   var favorites: RecipeDetails!
   var detailService: DetailRecipeService!
   var recipe:Detail?
   let expectation = XCTestExpectation(description: "Wait for queue change")
   
   override func setUp() {
      super.setUp()
       detailService = DetailRecipeService()
      favorites = RecipeDetails(context: AppDelegate.persistentContainer.newBackgroundContext())
      for elements in RecipeDetails.all {
         AppDelegate.viewContext.delete(elements)
      }
      try? AppDelegate.viewContext.save()
   }
   func testGivenFavoritesIsEmptyWhenCheckFavoritesThenFavoritesAreNil() {
      XCTAssertTrue(RecipeDetails.all.isEmpty)
      XCTAssertEqual(RecipeDetails.all.count, 0)
   }
   
   func testGivenFavoritesIsEmptyWhenSavingRecipeThenFavoritesCountsOne(){
      // When
      detailService = DetailRecipeService(FakeNetworkRequest(data: FakeListResponseData.recipeDetailCorrectData, response: FakeListResponseData.responseOK, error: nil))
         
      detailService.getDetail(with: "Beef-And-Dried-Tomato-Salad-1445298") { (response, error) in
         self.favorites = RecipeDetails(context: AppDelegate.viewContext)
         self.favorites.name = response?.name
         self.favorites.length = response?.totalTime
         self.favorites.rating = "\(response?.rating ?? 0)"
         self.favorites.ingredients = response?.ingredientLines.joined(separator: ", ")
         self.favorites.id = response?.id
         try? AppDelegate.viewContext.save()
         XCTAssertFalse(RecipeDetails.all.isEmpty)
         XCTAssertEqual(RecipeDetails.all.count, 1)
         XCTAssertEqual(self.favorites.name, response?.name)
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 0.05)
   }
   
   func testGivenFavoritesCountIsOneWhenDeletingFavoritesThenFavoritesIsEmpty(){
      // Given
      XCTAssertTrue(RecipeDetails.all.isEmpty)
      XCTAssertEqual(RecipeDetails.all.count, 0)
      
      //When
      detailService = DetailRecipeService(FakeNetworkRequest(data: FakeListResponseData.recipeDetailCorrectData, response: FakeListResponseData.responseOK, error: nil))
      
      detailService.getDetail(with: "Beef-And-Dried-Tomato-Salad-1445298") { (response, error) in
         self.favorites = RecipeDetails(context: AppDelegate.viewContext)
         self.favorites.name = response?.name
         self.favorites.length = response?.totalTime
         self.favorites.rating = "\(response?.rating ?? 0)"
         self.favorites.ingredients = response?.ingredientLines.joined(separator: ", ")
         self.favorites.id = response?.id
         try? AppDelegate.viewContext.save()
         XCTAssertFalse(RecipeDetails.all.isEmpty)
         XCTAssertEqual(RecipeDetails.all.count, 1)
         XCTAssertEqual(self.favorites.name, response?.name)
         self.expectation.fulfill()
      }
      wait(for: [expectation], timeout: 0.05)
      //Then
      let recipeId = "Beef-And-Dried-Tomato-Salad-1445298"
      for favorite in RecipeDetails.all where (recipeId == self.favorites.id) {
         AppDelegate.viewContext.delete(favorite)
         self.expectation.fulfill()
      }
      try? AppDelegate.viewContext.save()
      XCTAssertTrue(RecipeDetails.all.isEmpty)
      XCTAssertEqual(RecipeDetails.all.count, 0)
   }
}
