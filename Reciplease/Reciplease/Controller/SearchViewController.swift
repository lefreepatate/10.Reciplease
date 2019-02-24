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
   @IBAction func searchRecipesButton(_ sender: UIButton) {

   }
   override func viewDidLoad() {
      super.viewDidLoad()
      ingredientsList.text = "Tomatoe Bacon"
//      refreshList()
   }
   @IBAction func addIngredientTappedButton(_ sender: UIButton) {
      addIngredients()
   }
   @IBAction func clearTappedButton(_ sender: UIButton) {
      RecipeService.shared.ingredients = []
      ingredientsList.text = ""
   }
   func addIngredients() {
      guard let name = searchBar.text else { return }
      ingredient.name = name
      RecipeService.shared.addIngredient(ingredient: ingredient)
      ingredientsList.text += ingredient.name + "\n"
      searchBar.text = ""
   }
   
   func refreshList() {
      for _ in ingredientsList.text.components(separatedBy: "\n") {
         ingredientsList.text = ""
         for recipeIngredient in RecipeService.shared.ingredients {
            ingredientsList.text += recipeIngredient.name + "\n"
         }
      }
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

