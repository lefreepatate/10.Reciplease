//
//  PresentTableTableViewCell.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 06/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class PresentTableViewCell: UITableViewCell {
   @IBOutlet weak var whiteView: UIView!
   @IBOutlet weak var photoView: UIImageView!
   @IBOutlet weak var favoriteReceip: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      addShadow()
   }
   private func addShadow(){
      whiteView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
      whiteView.layer.shadowRadius = 2.0
      whiteView.layer.shadowOffset = CGSize(width: 2, height: 2)
      whiteView.layer.shadowOpacity = 2.0
   }
   
   func configure( title: String) {
//      photoView.image = UIImage(named: icon)
      favoriteReceip.text = title
   }
   
   //    override func setSelected(_ selected: Bool, animated: Bool) {
   //        super.setSelected(selected, animated: animated)
   //
   //        // Configure the view for the selected state
   //    }
   
}
