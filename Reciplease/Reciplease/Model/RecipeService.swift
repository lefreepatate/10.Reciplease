//
//  RecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire

class ReceipeService {
   static let shared = ReceipeService()
   private init() {}
   
   static func getReceips() {
      let id = "***"
      let key = "***"
      let ingredients = "\(getIngredients())"
      AF.request("https://api.yummly.com/v1/api/recipes?_app_id=\(id)&_app_key=\(key)&q=\(ingredients)")
         .responseJSON { response in
            debugPrint(response)
      }
   }
   
   static private func getIngredients() -> String {
      var q = ""
      for element in ReceipeService.shared.ingredients {
         q += "%20" + element.name
      }
      return q
   }
   
   var ingredients: [Ingredients] = []
   
   
   func addIngredient(ingredient: Ingredients) {
      ingredients.append(ingredient)
   }
   func removeIngredient(at index: Int) {
      if ingredients.count > 0 {
         ingredients.remove(at: index)
      }
   }
   private struct Keys {
      static var ingredient = "\(ReceipeService.shared.ingredients)"
   }
   
   static var favorites: String {
      
      get {
         return UserDefaults.standard.string(forKey: Keys.ingredient) ?? ""
      }
      set {
         UserDefaults.standard.set(newValue, forKey: Keys.ingredient)
      }
   }
}
