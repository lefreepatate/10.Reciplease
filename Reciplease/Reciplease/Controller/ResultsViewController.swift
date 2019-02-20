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
   var recipes: [[String: Any]] =  [[String: Any]]()
   var ingredient = Ingredients()
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      RecipeService.shared.getRecipes { (response, error) in
         if let response = response {
            self.recipes = response
            self.tableView.reloadData()
         } else if let error = error {
            print("Error: \(error)")
         }
      }
   }
   @IBAction func favoriteButton(_ sender: UIButton) {
      for cell in tableView.visibleCells {
         addFavorite(with: (cell.textLabel?.text) ?? "nada")
      }
   }
   func addFavorite(with name: String) {
      // Appelle le coredata
      ingredient.name = name
      // Enregistre dans le contexte via core data
      try? AppDelegate.viewContext.save()
      navigationController?.popViewController(animated: true)
   }
}
extension ResultsViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipes.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Création de la cellule
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as? RecipesTableViewcell else { return UITableViewCell() }
      // Récupération des données à insérer
      if self.recipes.count > 0 {
         let recipe = recipes[indexPath.row]
         let ingredients =  recipe["ingredients"] as? [String] ?? ["ingredients"]
         let imgURL = recipe["smallImageUrls"] as? [String] ?? ["image"]
         //         self.getAlamofireImage(with: imgURL.joined(separator: ""))
         cell.recipeTitle?.text = "\(recipe["recipeName"]  ?? "Titre")"
         cell.ingredientsDescr?.text = ingredients.joined(separator: ", ")
         cell.notation?.text = "\(recipe["rating"] ?? "note")"
         cell.length?.text = "\((recipe["totalTimeInSeconds"] as! Int) / 60) min"
         Alamofire.request(imgURL.joined(separator: "")).responseImage { (response) in
            if let image = response.result.value {
               let size = CGSize(width: 100, height: 100)
               let scaledImage = image.af_imageScaled(to: size)
               DispatchQueue.main.async {
                  cell.picture?.image = scaledImage
               }
            }
         }
      }
      return cell
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
