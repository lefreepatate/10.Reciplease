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
   init() {}
   var ingredients: [Ingredients] = []

   typealias WebServiceResponse = ([[String: Any]]?, Error?) -> Void
   
   func getRecipes(completion: @escaping WebServiceResponse) {
      let urlRequest = getUrlRequest()
      Alamofire.request(urlRequest).responseJSON { response in
         if let jsonArray = response.result.value as! [String: Any]? {
            if let recipeResponse = jsonArray["matches"] as! [[String: Any]]? {
               completion(recipeResponse, nil)
            }
         }
      }
   }
   
   func getImage(with stringURL : String, completion : @escaping (UIImage?, Error?) -> Void) {
      Alamofire.request(stringURL).responseImage { (response) in
         if let image = response.result.value {
            let size = CGSize(width: 90, height: 90)
            let scaledImage = image.af_imageScaled(to: size)
            completion(scaledImage, nil)
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
      for element in ingredients {
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
