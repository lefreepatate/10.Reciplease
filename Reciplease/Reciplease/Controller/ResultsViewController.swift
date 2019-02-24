//
//  SecondViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage
import Alamofire

class ResultsViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
   var recipes = [[String: Any]]()
   var recipeImage = UIImage()
   var favorite = Favorites(context: AppDelegate.viewContext)
   
   override func viewDidLoad() {
      super.viewDidLoad()
      alamofireRecipes()
   }
   private func alamofireRecipes() {
      RecipeService.shared.getRecipes { (response, error) in
         if let response = response {
            self.recipes = response
            self.tableView.reloadData()
         } else if let error = error {
            print("Error: \(error)")
         }
      }
   }
   private func cellImage(with url: String) {
      RecipeService.shared.getImage(with: url) { (image, error) in
         if let image = image {
            self.recipeImage = image
         } else if let error = error {
            print(error)
         }
      }
   }
}
extension ResultsViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipes.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesTableViewcell else { return UITableViewCell() }
      if self.recipes.count > 0 {
         let recipe = recipes[indexPath.row]
         let ingredients =  recipe["ingredients"] as? [String] ?? ["ingredients"]
         cell.recipeTitle?.text = "\(recipe["recipeName"]  ?? "Titre")"
         cell.ingredientsDescr?.text = ingredients.joined(separator: ", ")
         cell.notation?.text = "\(recipe["rating"] ?? "note")"
         cell.length?.text = "\((recipe["totalTimeInSeconds"] as! Int) / 60) min"
         if let imgURL = recipe["smallImageUrls"] as? [String] {
            self.cellImage(with: imgURL.joined(separator: ""))
            DispatchQueue.main.async {
               cell.picture?.image = self.recipeImage
            }
         }
      }
      return cell
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
      let recipe = recipes[indexPath.row]
      destinationVC.getRecipeID = recipe["id"] as! String
      print(destinationVC.getRecipeID)
      self.navigationController?.pushViewController(destinationVC, animated: true)
   }
}
extension ResultsViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         // Supprimer d'abord les données de la cellule
         recipes.remove(at: indexPath.row)
         // Puis la cellule
         tableView.deleteRows(at: [indexPath], with:.middle)
         try? AppDelegate.viewContext.save()
      }
   }
}
