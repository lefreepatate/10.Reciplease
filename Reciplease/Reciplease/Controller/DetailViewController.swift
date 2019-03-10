//
//  DetailRecipe.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 22/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreData

class DetailViewController: UIViewController {
   
   @IBOutlet weak var recipeTitle: UILabel!
   @IBOutlet weak var recipeImage: UIImageView!
   @IBOutlet weak var recipeIngredients: UITextField!
   @IBOutlet weak var recipeRating: UILabel!
   @IBOutlet weak var recipeLenght: UILabel!
   @IBOutlet weak var recipeDetailsButton: UIButton!
   @IBOutlet weak var titleImageview: UIView!
   @IBOutlet weak var recipeImageView: UIView!
   
   var getRecipeID = String()
   var recipe:Detail?
   var recipes = RecipeDetails(context: AppDelegate.viewContext)
   override func viewDidLoad() {
      super.viewDidLoad()
      favoriteButtonNavigationBar()
      getRecipeDetails()
      getDesign()
   }
   @IBAction func getRecipeButton(_ sender: Any) {
      let stringURL = recipe?.source.sourceRecipeUrl
      guard let url = URL(string: stringURL ?? "") else {return}
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
   }
   
   func getRecipeDetails() {
      DetailRecipeService.shared.getDetail(with: getRecipeID) { (response, error) in
         if let response = response  {
            self.recipe = response
            self.setDatas()
         } else if let error = error {
            print(error)
         }
      }
   }
   private func detailImage(with url: String){
      DetailRecipeService.shared.getDetailImage(with: url) { (image, error) in
         if let image = image {
            self.recipeImage.contentMode = .scaleAspectFill
            self.recipeImage?.image = image
         } else if let error = error {
            print(error)
         }
      }
   }
   @objc private func saveFavorite() {
//      guard let favoriteName = recipeTitle.text,
//         let image = recipeImage.image?.pngData(),
//         let length = recipeLenght.text,
//         let ingredients = recipeIngredients.text,
//         let rating = recipeRating.text,
//         let id = recipe?.id else {return}
//
      recipes.name = recipe?.name
      recipes.length = recipe?.totalTime
      recipes.rating = "\(recipe?.rating ?? 0)"
      recipes.image = recipeImage.image?.pngData()
      recipes.ingredients = recipe?.ingredientLines.joined(separator: ", ")
      recipes.id = recipe?.id
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      try? AppDelegate.viewContext.save()
   }
   
   @objc private func deleteFavorite() {
      for recipes in RecipeDetails.all where (getRecipeID == recipes.id) {
         recipes.image?.removeAll()
         AppDelegate.viewContext.delete(recipes)
      }
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
   }
  
   func setDatas(){
      let urlImage = recipe?.images[0].hostedLargeUrl
      let ingredients = recipe?.ingredientLines.joined(separator: "\n✓ ")
      detailImage(with: urlImage ?? "detail_img")
      recipeTitle.text = recipe?.name
      recipeIngredients?.insertText("✓ " + (ingredients ?? ""))
      recipeRating.text = "\(recipe?.rating ?? 0)"
      recipeLenght.text = recipe?.totalTime
   }
   func favoriteButtonNavigationBar() {
      let barButtonSave = UIBarButtonItem(title: "★", style: .plain, target: self, action: #selector(saveFavorite))
      let barButtonDelete = UIBarButtonItem(title: "★", style: .plain, target: self, action: #selector(deleteFavorite))
      self.navigationItem.setRightBarButton(barButtonSave, animated: false)
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      for recipes in RecipeDetails.all where (getRecipeID == recipes.id) {
         self.navigationItem.setRightBarButton(barButtonDelete, animated: false)
         navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      }
   }
}
extension DetailViewController {
   func getDesign() {
      recipeDetailsButton.layer.cornerRadius = recipeDetailsButton.frame.height/2
      recipeDetailsButton.clipsToBounds = true
      
      titleImageview.layer.cornerRadius = titleImageview.frame.height/4
      titleImageview.clipsToBounds = true
      recipeLenght.layer.cornerRadius = recipeLenght.frame.height/2
      recipeLenght.layer.borderWidth = 1
      recipeLenght.layer.borderColor = #colorLiteral(red: 1, green: 0.3724520802, blue: 0.3093305528, alpha: 1)
      recipeLenght.clipsToBounds = true
      
      recipeRating.layer.cornerRadius = 4
      recipeRating.clipsToBounds = true
   }
}
