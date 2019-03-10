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
   
   // MARK: -- FAKE DATATASK FOR TESTING
   private var session = URLSession.shared
   init(session: URLSession) {
      self.session = session
   }
   var ingredients: [Ingredients] = []
   typealias WebServiceResponse = (Bool, [Match]?, String?) -> Void
   
   func getRecipes(callback: @escaping WebServiceResponse) {
      let urlRequest = getUrlRequest()
      Alamofire.request(urlRequest).responseJSON { (response) in
            guard let data = response.data, response.error == nil else {
               callback(false, nil,  "Error while fetching data")
               return
            }
            guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data) else {
               return callback(false, nil, response.error.debugDescription)
               }
            if recipes.matches.isEmpty {
               callback(false, nil, "Aucune recette")
               return
            }
            callback(true, recipes.matches, nil)
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
      let id = "***"
      let key = "***"
      let ingredients = getIngredients()
      let parameters = "_app_id=\(id)&_app_key=\(key)&q=\(ingredients)"
      let apiURL = "https://api.yummly.com/v1/api/recipes?\(parameters)"
      let encondedString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
      let url = URL(string: encondedString)!
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      return urlRequest
   }
   
   private func getIngredients() -> String {
      var ingredientsArray = [String]()
      for element in ingredients {
         ingredientsArray.append(element.name)
      }
      return ingredientsArray.joined(separator: ", ")
   }
   func addIngredient(ingredient: Ingredients) {
      ingredients.append(ingredient)
   }
   //   func removeIngredient(at index: Int) {
   //      if ingredients.count > 0 {
   //         ingredients.remove(at: index)
   //      }
   //   }
   
}

