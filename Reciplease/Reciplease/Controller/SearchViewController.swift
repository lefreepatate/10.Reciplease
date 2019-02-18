//
//  FirstViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Alamofire
class SearchViewController: UIViewController {
   
   @IBOutlet weak var searchBar: UITextField!
   @IBOutlet weak var addButton: UIButton!
   @IBOutlet weak var clearButton: UIButton!
   @IBOutlet weak var ingredientsList: UITextView!
   var ingredient = Ingredients()
   var receips = [[String: Any]]()
   @IBAction func searchReceipsButton(_ sender: UIButton) {
      print("ok")
      ReceipeService.getReceips()
      }
   override func viewDidLoad() {
      super.viewDidLoad()
//      refreshList()

      // Do any additional setup after loading the view, typically from a nib.
   }
   @IBAction func addIngredientTappedButton(_ sender: UIButton) {
      addIngredients()
   }
   @IBAction func clearTappedButton(_ sender: UIButton) {
      ReceipeService.shared.ingredients = []
      ingredientsList.text = ""
      try? AppDelegate.viewContext.save()
   }
   func addIngredients() {
      guard let name = searchBar.text else { return }
      ingredient.name = name
      ReceipeService.shared.addIngredient(ingredient: ingredient)
      ingredientsList.text += ingredient.name + "\n"
      searchBar.text = ""
   }
   
   func refreshList() {
      for _ in ingredientsList.text.components(separatedBy: "\n") {
         ingredientsList.text = "" 
         for receipIngredient in ReceipeService.shared.ingredients {
            ingredientsList.text += receipIngredient.name + "\n"
         }
      }
   }
   func setReceips(){

   }
}
extension SearchViewController {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // compte le nombre d'éléments par cellule afin que lors de la récupération il ne plante pas
      return receips.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      var ingredients = [ingredient]
      // Création de la cellule
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "Results", for: indexPath)
         as? ResultsTableViewCell else { return UITableViewCell() }
      // Récupération des données à insérer
      let receip = ingredients[indexPath.row]
      cell.title?.text = receip.name
      cell.ingredientsDescr?.text = "\(receip)"
      try? AppDelegate.viewContext.save()
      // Informer où vont les informations à partir du PresentTAbleViewCell
      //      cell.configure(title: receip.name! )
      return cell
   }
}
extension SearchViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      addIngredients()
      return true
   }
   @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      searchBar.resignFirstResponder()
   }
}

