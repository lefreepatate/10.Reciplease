//
//  AllergiesViewController.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 12/03/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit

class AllergiesViewController: UIViewController {
   
   @IBOutlet weak var backgroundView: UIView!
   @IBOutlet var radioButtonCollection: [UIButton]!
   @IBOutlet weak var doneButton: UIButton!
   @IBAction func allergieButtonTapped(_ sender: UIButton) {
      checkButton(on: sender)
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      refreshAllergies()
      getDesign()
   }
   
   var allergies = Allergies()
   
   func checkButton(on button: UIButton){
      button.setImage(UIImage(named: "checkButtonOFF"), for: .normal)
      button.setImage(UIImage(named: "checkButtonON"), for: .selected)
      guard let name = button.titleLabel?.text else {return}
      allergies.name = name
      if !button.isSelected {
         button.isSelected = true
         RecipeService.shared.allergiesArray.append(allergies)
      } else {
         button.isSelected = false
         deleteAllergie(allergy: name)
      }
   }
   
   private func refreshAllergies() {
      for allergyList in RecipeService.shared.allergiesArray {
         for button in radioButtonCollection where allergyList.name == button.titleLabel?.text {
            button.setImage(UIImage(named: "checkButtonON"), for: .selected)
            button.isSelected = true
         }
      }
   }
   
   private func deleteAllergie(allergy name: String) {
      for allergie in RecipeService.shared.allergiesArray {
         if let index: Int = RecipeService.shared.allergiesArray.index(
            where: { _ in allergie.name == name }) {
            RecipeService.shared.allergiesArray.remove(at: index)
         }
      }
   }
   
   @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
       dismiss(animated: true, completion: nil)
   }
}
extension AllergiesViewController {
   func getDesign(){
      backgroundView.layer.cornerRadius = 10
      backgroundView.clipsToBounds = true
      doneButton.layer.cornerRadius = 10
      doneButton.clipsToBounds = true
   }
}
