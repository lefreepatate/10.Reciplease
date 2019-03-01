//
//  Favorites.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 22/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import CoreData

class Favorites: NSManagedObject {
   private(set) var favorites = [Favorites]()
   static var all : [Favorites] {
      let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
      guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
      return favorites
   }
   func removeFavorite(at index: Int) {
      if favorites.count > 0 {
         favorites.remove(at: index)
      }
   }
}
