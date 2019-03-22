//
//  FakeRecipeListResponseData.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 14/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class FakeListResponseData {
   
   static var recipeCorrectData: Data? {
      let bundle = Bundle(for: FakeListResponseData.self)
      let bundleUrl = bundle.url(forResource: "RecipeList", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static var recipeAllergyCorrectData: Data? {
      let bundle = Bundle(for: FakeListResponseData.self)
      let bundleUrl = bundle.url(forResource: "RecipeListWithAllergies", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static var recipeDetailCorrectData: Data? {
      let bundle = Bundle(for: FakeListResponseData.self)
      let bundleUrl = bundle.url(forResource: "RecipeDetail", withExtension: "json")
      return try! Data(contentsOf: bundleUrl!)
   }
   
   static let responseOK =
      HTTPURLResponse(url: URL(string: "https://fake.com")!, statusCode: 200, httpVersion: nil, headerFields:nil)
   static let responseKO =
      HTTPURLResponse(url: URL(string: "https://fake.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
   
   static let incorrectRecipeData = "erreur".data(using: .utf8)
   
   class RecipeError: Error {}
   static let error = RecipeError()
}

