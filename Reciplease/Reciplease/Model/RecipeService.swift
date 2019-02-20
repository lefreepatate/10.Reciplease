//
//  RecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire

class RecipeService {
   static let shared = RecipeService()
   init() {}
   var ingredients: [Ingredients] = []
   private struct Keys {
      static var ingredient = "\(RecipeService.shared.ingredients)"
   }
   static var favorites: String {
      
      get {
         return UserDefaults.standard.string(forKey: Keys.ingredient) ?? ""
      }
      set {
         UserDefaults.standard.set(newValue, forKey: Keys.ingredient)
      }
   }
   typealias WebServiceResponse = ([Reciplease]?, Error?) -> Void
   
   func getRecipes(completion: @escaping WebServiceResponse) {
      let urlRequest = getUrlRequest()
      AF.request(urlRequest).responseJSON { response in
         if let error = response.error {
            print(error)
            completion(nil, error)
         } else if let responseJSON = try? JSONDecoder().decode(Reciplease.self, from: (response.data)!) {
            completion([responseJSON], nil)
         }
      }
   }
   
   private func getUrlRequest() -> URLRequest {
      let apiURL = "https://api.yummly.com/v1/api/recipes"
      let id = "***"
      let key = "***"
      let ingredients = "\(getIngredients())"
      let parameters = "?_app_id=\(id)&_app_key=\(key)&q=\(ingredients)"
      let url = URL(string: apiURL + parameters)!
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      return urlRequest
   }
   
   private func getIngredients() -> String {
      var q = ""
      for element in RecipeService.shared.ingredients {
         q += element.name + "+"
      }
      return q
   }
   func addIngredient(ingredient: Ingredients) {
      ingredients.append(ingredient)
   }
   func removeIngredient(at index: Int) {
      if ingredients.count > 0 {
         ingredients.remove(at: index)
      }
   }
   
}
