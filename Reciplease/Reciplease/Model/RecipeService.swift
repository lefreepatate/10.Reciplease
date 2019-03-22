//
//  RecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class RecipeService {
   
   static let shared = RecipeService()
   
   // MARK: -- FAKE DATATASK FOR TESTING
   let networkRequest: NetworkRequest
   init(_ networkRequest: NetworkRequest = RealNetworkRequest()) {
      self.networkRequest = networkRequest
   }
   
   var ingredientsArray = [Ingredients]()
   var allergiesArray = [Allergies]()
   
   func getRecipes(completion: @escaping (Recipe?, Error?) -> Void) {
      let urlRequest = getUrlRequest()
      networkRequest.getRequest(urlRequest) { (response, error) in
         completion(response, nil)
      }
   }
   
   private func getUrlRequest() -> URL {
      let id = "***"
      let key = "***"
      let allergies = getAllergies()
      let ingredients = getIngredients()
      let parameters = "_app_id=\(id)&_app_key=\(key)&q=\(ingredients + allergies)"
      let apiURL = "https://api.yummly.com/v1/api/recipes?\(parameters)"
      let encondedString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
      let url = URL(string: encondedString)!
      print(url)
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

