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
   
   var ingredientsArray = [Ingredients]()
   var allergiesArray = [Allergies]()
   typealias WebServiceResponse = ([Match]?, Error?) -> Void
   
   func getRecipes(completion: @escaping WebServiceResponse) {
      let urlRequest = getUrlRequest()
      Alamofire.request(urlRequest).responseJSON { (response) in
         print(response)
         guard let data = response.data, response.error == nil
            else { return  completion(nil, response.error) }
         guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data)
            else { return  completion(nil, response.error) }

         if recipes.matches.isEmpty {
            return completion(nil, response.error)
         }
        return completion(recipes.matches, nil)
         
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
      let allergies = getAllergies()
      let ingredients = getIngredients()
      let parameters = "_app_id=\(id)&_app_key=\(key)&q=\(ingredients + allergies)"
      let apiURL = "https://api.yummly.com/v1/api/recipes?\(parameters)"
      let encondedString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
      let url = URL(string: encondedString)!
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      print("urlrequest:", urlRequest)
      return urlRequest
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

