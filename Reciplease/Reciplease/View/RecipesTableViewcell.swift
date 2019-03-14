//
//  PresentTableTableViewCell.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 06/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class RecipesTableViewcell: UITableViewCell {
   @IBOutlet weak var picture: UIImageView!
   @IBOutlet weak var recipeTitle: UILabel!
   @IBOutlet weak var length: UILabel!
   @IBOutlet weak var ingredientsDescr: UILabel!
   @IBOutlet weak var notation: UILabel!
   override func awakeFromNib() {
      super.awakeFromNib()
      getDesign()
   }
   
   private func getDesign(){
      length.clipsToBounds = true
      length.layer.cornerRadius = length.frame.height/2
   }   
}
