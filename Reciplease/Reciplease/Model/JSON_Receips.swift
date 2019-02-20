//
//  JSON_Recipes.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 19/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation

struct Reciplease: Codable {
   let criteria: Criteria
   let matches: [Match]
   let facetCounts: FacetCounts
   let totalMatchCount: Int
   let attribution: Attribution
}

struct Attribution: Codable {
   let html: String
   let url: String
   let text: String
   let logo: String
}

struct Criteria: Codable {
   let q: String
   let allowedIngredient, excludedIngredient: JSONNull?
}

struct FacetCounts: Codable {
}

struct Match: Codable {
   let imageUrlsBySize: ImageUrlsBySize?
   let sourceDisplayName: String
   let ingredients: [String]?
   let id: String
   let smallImageUrls: [String]
   let recipeName: String?
   let totalTimeInSeconds: Int
   let attributes: Attributes
   let flavors: Flavors?
   let rating: Int?
}

struct Attributes: Codable {
   let course, holiday, cuisine: [String]?
}

struct Flavors: Codable {
   let piquant, meaty, bitter, sweet: Double
   let sour, salty: Double
}

struct ImageUrlsBySize: Codable {
   let the90: String
   
   enum CodingKeys: String, CodingKey {
      case the90 = "90"
   }
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
   
   public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
      return true
   }
   
   public var hashValue: Int {
      return 0
   }
   
   public init() {}
   
   public required init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if !container.decodeNil() {
         throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
      }
   }
   
   public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encodeNil()
   }
}
