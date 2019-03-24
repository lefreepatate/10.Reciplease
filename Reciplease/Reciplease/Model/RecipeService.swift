//
//  RecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class RecipeService {
   
   static let shared = RecipeService()
   var ingredientsArray = [Ingredients]()
   var allergiesArray = [Allergies]()
   
   // MARK: -- FAKE DATATASK FOR TESTING
   let networkRequest: NetworkRequest
   init(_ networkRequest: NetworkRequest = RealNetworkRequest()) {
      self.networkRequest = networkRequest
   }
   
   func getRecipes(completion: @escaping (Recipe?, Error?) -> Void) {
      let urlRequest = getUrl()
      networkRequest.getRequest(urlRequest) { (response, error) in
         completion(response, nil)
      }
   }
   
   private func getUrl() -> URL {
      let id = "***"
      let key = "***"
      let allergies = getAllergies()
      let ingredients = getIngredients()
      let parameters = "_app_id=\(id)&_app_key=\(key)&q=\(ingredients + allergies)&maxResult=15"
      let apiURL = "https://api.yummly.com/v1/api/recipes?\(parameters)"
      let encondedString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
      let url = URL(string: encondedString)!
      return url
   }
   
   private func getIngredients() -> String {
      var ingredients = String()
      for element in ingredientsArray {
         ingredients += element.name + " "
      }
      return ingredients
   }
   
   private func getAllergies() -> String {
      var allergies = String()
      for element in allergiesArray {
         allergies += element.name + " "
      }
      return allergies.isEmpty ?  "" : "&allowedAllergy=" + allergies
   }
}

