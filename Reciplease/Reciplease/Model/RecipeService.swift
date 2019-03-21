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

class RealNetworkRequest: NetworkRequest {
   func getRequest(_ url: URL, completion: @escaping ([Match]?, Error?) -> Void) {
      Alamofire.request(url).responseJSON { (response) in
         guard let data = response.data, response.error == nil else { return }
         guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data) else { return }
         completion(recipes.matches, nil)
      }
   }
}

class RecipeService {
   
   static let shared = RecipeService()
   
   // MARK: -- FAKE DATATASK FOR TESTING
   let networkRequest: NetworkRequest
   init(_ networkRequest: NetworkRequest = RealNetworkRequest()) {
      self.networkRequest = networkRequest
   }
   
   var ingredientsArray = [Ingredients]()
   var allergiesArray = [Allergies]()
   
   func getRecipes(completion: @escaping ([Match]?, Error?) -> Void) {
      let urlRequest = getUrlRequest()
      networkRequest.getRequest(urlRequest) { (response, error) in
         completion(response, nil)
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
   
   private func getUrlRequest() -> URL {
      let id = "***"
      let key = "***"
      let allergies = getAllergies()
      let ingredients = getIngredients()
      let parameters = "_app_id=\(id)&_app_key=\(key)&q=\(ingredients + allergies)"
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

