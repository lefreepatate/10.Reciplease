//
//  FirstViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 05/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class SearchViewController: UIViewController {
   
   @IBOutlet weak var searchBar: UITextField!
   @IBOutlet weak var searchButton: UIButton!
   @IBOutlet weak var addButton: UIButton!
   @IBOutlet weak var clearButton: UIButton!
   @IBOutlet weak var ingredientsList: UITextView!
   @IBOutlet weak var containerView: UIView!
   @IBOutlet weak var listView: UIView!
   @IBOutlet weak var switchAllergies: UISwitch!
   @IBOutlet weak var allergiesAddButton: UIButton!
   @IBAction func switchAction(_ sender: UISwitch) {
    checkAllergies()
   }
   @IBAction func addIngredientTappedButton(_ sender: UIButton) {
      addIngredients()
   }
   @IBAction func clearTappedButton(_ sender: UIButton) {
      resetList()
   }
   @IBAction func searchRecipesButton(_ sender: UIButton) {
      checkList()
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      getDesign()
   }
   
   var ingredient = Ingredients()
   
   private func checkAllergies() {
      if switchAllergies.isOn {
         allergiesAddButton.isHidden = false
      } else {
         RecipeService.shared.allergiesArray = []
         allergiesAddButton.isHidden = true
      }
   }
   private func checkList() {
      if ingredientsList.text != "" {
         performSegue(withIdentifier: "Results", sender: nil)
      } else {
         presentAlert(with: "Your fridge is empty ?")
      }
   }
   private func resetList() {
      RecipeService.shared.ingredientsArray = []
      switchAllergies.isOn = false
      ingredientsList.text = ""
   }
   func addIngredients() {
      guard let name = searchBar.text else { return }
      ingredient.name = name
      RecipeService.shared.ingredientsArray.append(ingredient)
      ingredientsList.text += "✓" + ingredient.name + "\n"
      searchBar.text = ""
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
extension SearchViewController {
   func getDesign() {
      listView.layer.borderWidth = 1
      listView.layer.borderColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      listView.layer.cornerRadius = listView.frame.width/16
      listView.clipsToBounds = true
      searchButton.layer.cornerRadius = searchButton.frame.height/2
      clearButton.layer.cornerRadius = clearButton.frame.height/2
      addButton.layer.cornerRadius = addButton.frame.height/2
      searchButton.clipsToBounds = true
      clearButton.clipsToBounds = true
      addButton.clipsToBounds = true
      allergiesAddButton.layer.cornerRadius = allergiesAddButton.frame.height/2
      allergiesAddButton.clipsToBounds = true
   }
}

