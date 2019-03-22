//
//  FakeDetailNetworkRequest.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 22/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
@testable import Reciplease

struct FakeDetailNetworkRequest: NetworkRequest {
   
   
   let data: Data?
   let response: HTTPURLResponse?
   let error: Error?
   
   init(data: Data?, response: HTTPURLResponse?, error: Error?){
      self.data = data
      self.response = response
      self.error = error
   }
   func getRequest<Type: Decodable>(_ url: URL, completion: @escaping (Type?, Error?) -> Void) {
      let result = try? JSONDecoder().decode(Type.self, from: data!)
      completion(result, nil)
   }
}
