//
//  FakeNetworkRequest.swift
//  RecipleaseTests
//
//  Created by Carlos Garcia-Muskat on 19/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeNetworkRequest: NetworkRequest {
   let response: HTTPURLResponse?
   let error: Error?
   let data: Data?
   
   init(data: Data?, response: HTTPURLResponse?, error: Error?){
      self.data = data
      self.response = response
      self.error = error
   }
   
   func getRequest(_ url: URL, completion: @escaping([Match]?, Error?) -> Void) {
      let result = try? JSONDecoder().decode(Recipe.self, from: self.data!)
      completion(result!.matches, nil)
   }
}

