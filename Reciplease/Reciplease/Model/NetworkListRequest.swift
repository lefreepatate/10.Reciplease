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
         completion(decoded, nil)
      }
   }
}
