//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {

   func testGivenIngredientsIsEmptyWhenAddingIngredientThenIngredientHave1More() {
      // Given
      var ingredients = Ingredients()
      ingredients.name = ""
      // When
      ingredients.name = "tomatoe"
      // Then
      XCTAssertEqual(ingredients.name, "tomatoe")
   }

}
