//
//  NetworkRequest.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 17/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRequest {
   func getRequest<Type: Decodable>(_ url: URL, completion: @escaping (Type?, Error?) -> Void)
}

struct RealNetworkRequest: NetworkRequest {
   func getRequest<Type: Decodable>(_ url: URL, completion: @escaping (Type?, Error?) -> Void) {
      Alamofire.request(url).responseData { (response) in
         guard let data = response.data, response.error == nil else { return }
         guard let decoded = try? JSONDecoder().decode(Type.self, from: data) else { return }
         print(decoded)
         completion(decoded, nil)
      }
   }
}

//struct DetailNetworkRequest: NetworkRequest {
//   func getRequest(_ url: URL, completion: @escaping (Detail?, Error?) -> Void) {
//      Alamofire.request(url).responseJSON { (response) in
//         guard let data = response.data, response.error == nil
//            else { return  completion(nil, response.error) }
//         guard let detail = try? JSONDecoder().decode(Detail.self, from: data)
//            else { return completion(nil, response.error) }
//         completion(detail, nil)
//      }
//   }
//}


//struct RealNetworkRequest: NetworkRequest {
//   func getRequest<Recipe: Decodable>(_ url: URL, completion: @escaping (Recipe?, Error?) -> Void) {
//      Alamofire.request(url).responseJSON { (response) in
//         guard let data = response.data, response.error == nil
//            else { return  completion(nil, response.error) }
//         guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data)
//            else { return completion(nil, response.error) }
//         completion(recipes, nil)
//      }
//   }
//}
//
//class DetailNetworkRequest: NetworkRequest {
//   func getRequest<Detail: Decodable>(_ url: URL, completion: @escaping (Detail?, Error?) -> Void) {
//      Alamofire.request(url).responseJSON { (response) in
//         guard let data = response.data, response.error == nil
//            else { return  completion(nil, response.error) }
//         guard let detail = try? JSONDecoder().decode(Detail.self, from: data)
//            else { return completion(nil, response.error) }
//         completion(detail, nil)
//      }
//   }
//}






//protocol NetworkListRequest {
//   func getRequest(_ url: URL, completion: @escaping (Codable?, Error?) -> Void)
//}
//
//protocol NetworkDetailRequest {
//   func getRequest(_ url: URL, completion: @escaping (Detail?, Error?) -> Void)
//}
//
//class RecipesNetworkRequest: NetworkListRequest {
//   func getRequest(_ url: URL, completion: @escaping ([Match]?, Error?) -> Void) {
//      Alamofire.request(url).responseJSON { (response) in
//         guard let data = response.data, response.error == nil else { return }
//         guard let recipes = try? JSONDecoder().decode(Recipe.self, from: data) else { return }
//         completion(recipes.matches, nil)
//      }
//   }
//}
//class DetailNetworkRequest: NetworkDetailRequest {
//   func getRequest(_ url: URL, completion: @escaping (Detail?, Error?) -> Void) {
//      Alamofire.request(url).responseJSON { (response) in
//         guard let data = response.data, response.error == nil
//            else { return  completion(nil, response.error) }
//         guard let detail = try? JSONDecoder().decode(Detail.self, from: data)
//            else { return completion(nil, response.error) }
//         completion(detail, nil)
//      }
//   }
//}

