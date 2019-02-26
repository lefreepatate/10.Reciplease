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

class DetailViewController: UIViewController {
   
   @IBOutlet weak var recipeTitle: UILabel!
   @IBOutlet weak var recipeImage: UIImageView?
   @IBOutlet weak var recipeIngredients: UITextView!
   @IBOutlet weak var recipeRating: UILabel!
   @IBOutlet weak var recipeLenght: UILabel!
   
   var getRecipeID = ""
   var recipeData: [String:Any]?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      getRecipeDetails()
   }
   @IBAction func getRecipeButton(_ sender: Any) {
      UIApplication.shared.open(URL(string: getSafariURL())!,
                                options: [:], completionHandler: nil)
   }
   
   @IBAction func favoriteTappedButton(_ sender: UIButton) {
      saveFavorite()
   }
   func getRecipeDetails() {
      DetailRecipeService.shared.getDetail(with: getRecipeID) { (response, error) in
         if let response = response  {
            self.recipeData = response
            self.setDatas()
         } else if let error = error {
            print(error)
         }
      }
   }
   private func detailImage(with url: String){
      DetailRecipeService.shared.getDetailImage(with: url) { (image, error) in
         if let image = image {
            self.recipeImage?.image = image
         } else if let error = error {
            print(error)
         }
      }
   }
   private func saveFavorite() {
      guard let favoriteName = recipeTitle.text,
         let image = recipeImage?.image?.pngData(),
         let length = recipeLenght?.text,
         let ingredients = recipeIngredients.text,
         let rating = recipeRating.text,
         let id = recipeData!["id"] else {return}
      
      let favorite = Favorites(context: AppDelegate.viewContext)
      favorite.length = length
      favorite.rating = rating
      favorite.image = image
      favorite.name = favoriteName
      favorite.ingredients = ingredients
      favorite.id = (id as! String)
      
      try? AppDelegate.viewContext.save()
   }
   private func getSafariURL() -> String {
      guard let source = recipeData!["source"] as! [String:Any]? else { return "" }
      return (source["sourceRecipeUrl"] as! String?)!
   }
   func setDatas(){
      let images = self.recipeData!["images"] as! [[String:Any]]?
      let urlImage = images![0]["hostedLargeUrl"] as! String?
      self.detailImage(with: urlImage!)
      recipeTitle?.text = self.recipeData!["name"] as! String?
      recipeIngredients?.text = (self.recipeData!["ingredientLines"]
         as? [String])!.joined(separator: "\n")
      recipeRating?.text = "\(self.recipeData!["rating"] as! Int)"
      recipeLenght.text = "\((self.recipeData!["totalTimeInSeconds"] as! Int) / 60) Min"
   }
}
