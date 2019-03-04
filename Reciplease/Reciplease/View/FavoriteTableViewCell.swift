//
//  FavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 26/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
   @IBOutlet weak var titleLbl: UILabel!
   @IBOutlet weak var lengthlbl: UILabel!
   @IBOutlet weak var ingredientsLbl: UILabel!
   @IBOutlet weak var ratingLbl: UILabel!
   @IBOutlet weak var recipeImg: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      getDesign()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   func getDesign() {
//      listView.layer.borderWidth = 1
//      listView.layer.borderColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
//      listView.layer.cornerRadius = listView.frame.width/16
      lengthlbl.clipsToBounds = true
      lengthlbl.layer.cornerRadius = lengthlbl.frame.height/2
//      clearButton.layer.cornerRadius = clearButton.frame.height/2
      ratingLbl.layer.cornerRadius = 4
      ratingLbl.clipsToBounds = true
      recipeImg.layer.borderWidth = 1
      recipeImg.layer.borderColor = #colorLiteral(red: 0.1503180861, green: 1, blue: 0.4878128767, alpha: 1)
      recipeImg.layer.cornerRadius = recipeImg.frame.height/4
      recipeImg.clipsToBounds = true
//      clearButton.clipsToBounds = true
//      addButton.clipsToBounds = true
   }
}

