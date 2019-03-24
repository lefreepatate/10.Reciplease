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
   @IBOutlet weak var emptylabel: UILabel!
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   var recipes = [Match]()
   var recipeImage = UIImage()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      toggleActivityIndicator(shown: true)
      alamofireRecipes()
   }
   private func alamofireRecipes() {
      RecipeService.shared.getRecipes { (response, error) in
         if let response = response {
            self.recipes = response.matches!
            self.toggleActivityIndicator(shown: false)
            self.tableView.reloadData()
         } else if self.recipes.isEmpty {
            self.emptyResponse()
            self.presentAlert(with: "There was an error while downloading data!")
         }
      }
   }
   
   private func emptyResponse() {
      self.emptylabel.text = "Sorry!\n\nWe didn't find any recipes for you :(\n\nTry again!"
      self.tableView.isHidden = true
      self.activityIndicator.isHidden = true
   }
   
   private func toggleActivityIndicator(shown: Bool) {
      tableView.isHidden = shown
      activityIndicator.isHidden = !shown
   }
}
extension ResultsViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return recipes.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath)
         as? RecipesTableViewcell else { return UITableViewCell() }
      cell.picture?.image = UIImage(named: "results_img")
      let recipe = recipes[indexPath.row]
      let ingredients = recipe.ingredients
      let image = recipe.imageUrlsBySize
      cell.recipeTitle.text = recipe.recipeName
      cell.ingredientsDescr.text = ingredients.joined(separator: ", ")
      cell.notation.text = "\(String(describing: recipe.rating))"
      cell.length.text = "\(recipe.totalTimeInSeconds / 60) min"
      DispatchQueue.main.async {
         if let imageURL = image.the90 as String? {
            self.imageCellView(cell: cell, url: imageURL)
         }
      }
      return cell
   }
   private func imageCellView(cell: RecipesTableViewcell, url: String )  {
      UIImage.from(url, width: 90, height: 90) { (image) in
         if let image = image {
            self.recipeImage = image
         }
         cell.picture?.image = image
      }
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyBoard.instantiateViewController(
         withIdentifier: "DetailViewController") as! DetailViewController
      let recipe = recipes[indexPath.row]
      destinationVC.getRecipeID = recipe.id
      self.navigationController?.pushViewController(destinationVC, animated: true)
   }
}
extension ResultsViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                  forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         recipes.remove(at: indexPath.row)
         tableView.deleteRows(at: [indexPath], with:.middle)
         try? AppDelegate.viewContext.save()
      }
   }
}
extension UIImage {
   static func from(_ stringURL: String, width: Int, height: Int,
                    completion: @escaping (UIImage?) -> Void) {
      Alamofire.request(stringURL).responseImage { (response) in
         if let image = response.result.value {
            let size = CGSize(width: width, height: height)
            let scaledImage = image.af_imageScaled(to: size)
            completion(scaledImage)
         } else {
            completion(nil)
         }
      }
   }
}
