//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 26/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData
class FavoritesViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
   var recipes = [Favorites]()
   override func viewDidLoad() {
      super.viewDidLoad()
      let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
      guard let favorites = try? AppDelegate.viewContext.fetch(request) else {return}
      recipes = favorites
   }
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
   }
}
extension FavoritesViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipes.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
         as? FavoriteTableViewCell else { return UITableViewCell() }
      let recipe = recipes[indexPath.row]
      cell.titleLbl?.text = recipe.name
      cell.lengthlbl.text = recipe.length
      cell.ingredientsLbl.text = recipe.ingredients
      cell.ratingLbl.text = recipe.rating
      cell.recipeImg?.image = (recipe.image as! UIImage?) ?? nil
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController")
         as! DetailViewController
      let recipe = recipes[indexPath.row]
      destinationVC.getRecipeID = recipe.id ?? ""
      self.navigationController?.pushViewController(destinationVC, animated: true)
   }
}
extension FavoritesViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                  forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         recipes.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .middle)
         try? AppDelegate.viewContext.save()
      }
   }
}
