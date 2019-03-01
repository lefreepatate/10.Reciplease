//
//  DetailRecipeService.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 23/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DetailRecipeService {
   static let shared = DetailRecipeService()
   init() {}
   
   typealias WebServiceResponse = ([String:Any]?, Error?) -> Void
   
   func getDetail(with recipeId: String, completion: @escaping WebServiceResponse) {
      let urlRequest = getUrlRequest(with: recipeId)
      Alamofire.request(urlRequest).responseJSON { (response) in
         if let jsonArray = response.result.value as? [String:Any] {
            completion(jsonArray, nil)
            }
      }
   }
   
   func getDetailImage(with stringURL : String, completion : @escaping (UIImage?, Error?) -> Void) {
      Alamofire.request(stringURL).responseImage { (response) in
         if let image = response.result.value {
            let size = CGSize(width: 360, height: 360)
            let scaledImage = image.af_imageScaled(to: size)
            completion(scaledImage, nil)
         }
      }
   }
   
   private func getUrlRequest(with recipeId: String) -> URLRequest {
      let apiURL = "http://api.yummly.com/v1/api/recipe/"
      let id = "***"
      let key = "***"
      let recipeId = recipeId
      let parameters = "\(recipeId)?_app_id=\(id)&_app_key=\(key)"
      let url = URL(string: apiURL + parameters)!
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "GET"
      return urlRequest
   }
}
