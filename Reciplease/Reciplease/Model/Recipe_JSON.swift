//
//  Recipe_JSON.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 08/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
   var matches: [Match]
   
   enum CodingKeys: String, CodingKey {
      case matches = "matches"
   }
}

struct Match: Decodable {
   let imageUrlsBySize: ImageUrlsBySize
   let sourceDisplayName: String
   let ingredients: [String]
   let id: String
   let smallImageUrls: [String]
   let recipeName: String
   let totalTimeInSeconds: Int
   let rating: Int
}

struct ImageUrlsBySize: Decodable {
   let the90: String
   
   enum CodingKeys: String, CodingKey {
      case the90 = "90"
   }
}
