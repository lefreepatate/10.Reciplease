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
//      picture.layer.borderWidth = 1
//      picture.layer.borderColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
//      picture.layer.cornerRadius = picture.frame.height/4
//      picture.clipsToBounds = true
//      whiteView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
//      whiteView.layer.shadowRadius = 2.0
//      whiteView.layer.shadowOffset = CGSize(width: 2, height: 2)
//      whiteView.layer.shadowOpacity = 2.0
   }   
}
