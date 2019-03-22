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
      if switchAllergies.isOn {
         allergiesAddButton.isHidden = false
      } else {
         RecipeService.shared.allergiesArray = []
         allergiesAddButton.isHidden = true
      }
   }
   @IBAction func addIngredientTappedButton(_ sender: UIButton) {
      addIngredients()
   }
   @IBAction func clearTappedButton(_ sender: UIButton) {
      RecipeService.shared.ingredientsArray = []
      switchAllergies.isOn = false
      ingredientsList.text = ""
   }
   @IBAction func searchRecipesButton(_ sender: UIButton) {
      if ingredientsList.text != "" {
         performSegue(withIdentifier: "Results", sender: nil)
      } else {
         presentAlert(with: "Your fridge is empty ?")
      }
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      getDesign()
   }
   
   var ingredient = Ingredients()
   func addIngredients() {
      guard let name = searchBar.text else { return }
      ingredient.name = name
      RecipeService.shared.ingredientsArray.append(ingredient)
      ingredientsList.text += "✓" + ingredient.name + "\n"
      searchBar.text = ""
   }
   private func presentAlert(with message: String) {
      let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
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
   @IBAction func unwindToSearchVC(_ sender: UIStoryboardSegue) {
      allergiesAddButton.resignFirstResponder()
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

