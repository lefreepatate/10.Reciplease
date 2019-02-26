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
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
}
