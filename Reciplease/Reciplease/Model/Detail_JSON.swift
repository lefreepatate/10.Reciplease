//
//  Detail_JSON.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 10/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

struct Detail: Decodable {
   let totalTime: String
   let images: [Image]
   let name: String
   let source: Source
   let id: String
   let ingredientLines: [String]
   let rating: Int
   
   enum CodingKeys: String, CodingKey {
      case totalTime = "totalTime"
      case images = "images"
      case name = "name"
      case source = "source"
      case id = "id"
      case ingredientLines = "ingredientLines"
      case rating = "rating"
   }
}
struct Image: Decodable {
   let hostedLargeUrl: String
   
   enum CodingKeys: String, CodingKey {
      case hostedLargeUrl = "hostedLargeUrl"
   }
}
struct Source: Decodable {
   let sourceRecipeUrl: String
   
   enum CodingKeys: String, CodingKey {
      case sourceRecipeUrl = "sourceRecipeUrl"
   }
}
