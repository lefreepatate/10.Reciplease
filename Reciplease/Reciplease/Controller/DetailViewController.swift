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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   var getRecipeID = String()
   var recipe:Detail?
   override func viewDidLoad() {
      super.viewDidLoad()
      toggleActivityIndicator(shown: true)
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
            self.toggleActivityIndicator(shown: false)
         } else if let error = error {
            print(error)
         }
      }
   }
   private func detailImage(with url: String){
      UIImage.from(url, width: 360, height: 240) { (image) in
         if let image = image {
            self.recipeImage.contentMode = .scaleAspectFill
            self.recipeImage?.image = image
      }
   }
   }
   @objc private func saveFavorite() {
      let recipes = RecipeDetails(context: AppDelegate.viewContext)
      recipes.name = recipe?.name
      recipes.length = recipe?.totalTime
      recipes.rating = "\(recipe?.rating ?? 0)"
      recipes.image = recipeImage.image?.pngData()
      recipes.ingredients = recipe?.ingredientLines.joined(separator: ", ")
      recipes.id = recipe?.id
      navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      favoriteButtonNavigationBar()
      try? AppDelegate.viewContext.save()
   }
   
   @objc private func deleteFavorite() {
      for recipe in RecipeDetails.all where (getRecipeID == recipe.id) {
         recipe.image = nil
         AppDelegate.viewContext.delete(recipe)
      }
      favoriteButtonNavigationBar()
      try? AppDelegate.viewContext.save()
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
   private func toggleActivityIndicator(shown: Bool) {
      recipeImage.isHidden = shown
      recipeIngredients.isHidden = shown
      recipeRating.isHidden = shown
      recipeLenght.isHidden = shown
      recipeDetailsButton.isHidden = shown
      titleImageview.isHidden = shown
      recipeImageView.isHidden = shown
      recipeIngredients.isHidden = shown
      activityIndicator.isHidden = !shown
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
