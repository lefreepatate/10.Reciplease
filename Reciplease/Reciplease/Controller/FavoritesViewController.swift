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
   @IBOutlet weak var emptyLabel: UILabel!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   var recipes = Favorites.all
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      recipes = Favorites.all
      toggleActivityIndicator(shown: true)
      checkFavorites()
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
      cell.titleLbl.text = recipe.name
      cell.lengthlbl.text = recipe.length
      cell.ingredientsLbl.text = recipe.ingredients
      cell.ratingLbl.text = recipe.rating
      if let image = UIImage(data: recipe.image!) {
         DispatchQueue.main.async {
            cell.recipeImg.contentMode = .scaleAspectFit
            cell.recipeImg.image = image
         }
      }
      return cell
   }
   
   func favoriteImageCell(on image: UIImage) -> UIImage {
      let size = CGSize(width: 110, height: 110)
      let scaledImage = image.af_imageScaled(to: size)
      return scaledImage
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController")
         as? DetailViewController
      let recipe = recipes[indexPath.row]
      destinationVC?.getRecipeID = recipe.id ?? ""
      self.navigationController?.pushViewController(destinationVC!, animated: true)
   }
   private func checkFavorites() {
      if recipes.isEmpty {
         emptyResponse()
      } else {
         toggleActivityIndicator(shown: false)
      }
   }
   private func emptyResponse() {
      self.emptyLabel.text = "Hey! You don't have any favorites yet.\n\nTo get favorites press the ★ button\non the top right corner ;)"
      self.tableView.isHidden = true
      self.activityIndicator.isHidden = true
   }
   
   private func toggleActivityIndicator(shown: Bool) {
      tableView.isHidden = shown
      activityIndicator.isHidden = !shown
   }
}
extension FavoritesViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         recipes.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with: .middle)
         try? AppDelegate.viewContext.save()
      }
   }
}
