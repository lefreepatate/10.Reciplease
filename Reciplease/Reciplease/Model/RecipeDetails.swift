//
//  Favorites.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 22/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import CoreData

class RecipeDetails: NSManagedObject {
   static var all : [RecipeDetails] {
      let request: NSFetchRequest<RecipeDetails> = RecipeDetails.fetchRequest()
      request.sortDescriptors = [
         NSSortDescriptor(key: "length", ascending: true)
      ]
      guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
      return recipes
   }
}
