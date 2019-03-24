//
//  DetailRecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 23/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

class DetailRecipeService {
   
   static let shared = DetailRecipeService()
   
   // MARK: -- FAKE DATATASK FOR TESTING
   let networkRequest: NetworkRequest
   init(_ networkRequest: NetworkRequest = RealNetworkRequest()) {
      self.networkRequest = networkRequest
   }
   
   func getDetail(with recipeId: String, completion: @escaping (Detail?, Error?) -> Void) {
      let urlRequest = getUrl(with: recipeId)
      networkRequest.getRequest(urlRequest) { (response, error) in
         completion(response, nil)
      }
   }
   
   private func getUrl(with recipeId: String) -> URL {
      let id = "***"
      let key = "***"
      let recipeId = recipeId
      let parameters = "\(recipeId)?_app_id=\(id)&_app_key=\(key)"
      let apiURL = "https://api.yummly.com/v1/api/recipe/\(parameters)"
      let encondedString = apiURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
      let url = URL(string: encondedString)!
      return url
   }
}
