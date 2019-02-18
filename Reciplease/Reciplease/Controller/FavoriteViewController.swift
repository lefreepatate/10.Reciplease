//
//  SecondViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import CoreData
class FavoriteViewController: UIViewController {
   
   
   @IBOutlet weak var tableView: UITableView!
var ingredients = [Ingredients]()
   var ingredient = Ingredients()
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
      
   }

   @IBAction func favoriteButton(_ sender: UIButton) {
      
      for cell in tableView.visibleCells {
         addFavorite(with: (cell.textLabel?.text) ?? "nada")
      }
   }
//   fileprivate func displayFavoriteCells(with name: String) {
//      for favorite in Favorites.all {
//         guard let favorites = tableView.dequeueReusableCell(withIdentifier: "PresentReceipCell") as? PresentTableViewCell else {return}
//
//         favorite.name = ReceipeService.favorites
//         favorites.configure(title: ReceipeService.favorites)
//      }
//      print(name)
//   }
   func addFavorite(with name: String) {
      // Appelle le coredata
      ingredient.name = name
      // Enregistre dans le contexte via core data
      try? AppDelegate.viewContext.save()
      navigationController?.popViewController(animated: true)
   }
}
extension FavoriteViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // compte le nombre d'éléments par cellule afin que lors de la récupération il ne plante pas
      return ingredients.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Création de la cellule
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PresentReceipCell", for: indexPath) as? PresentTableViewCell else { return UITableViewCell() }
      // Récupération des données à insérer
      let receip = ingredients[indexPath.row]
      cell.textLabel!.text = receip.name
      try? AppDelegate.viewContext.save()
      // Informer où vont les informations à partir du PresentTAbleViewCell
//      cell.configure(title: receip.name! )
      return cell
   }
}

extension FavoriteViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         // Supprimer d'abord les données de la cellule
         ingredients.remove(at: indexPath.row)
         // Puis la cellule
         tableView.deleteRows(at: [indexPath], with:.middle)
         try? AppDelegate.viewContext.save()
      }
   }
}
