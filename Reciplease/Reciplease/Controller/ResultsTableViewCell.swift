//
//  ResultsTableViewCell.swift
//  Reciplease
//
//  Created by Carlos Garcia-Muskat on 16/02/2019.
//  Copyright © 2019 Carlos Garcia-Muskat. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
   @IBOutlet weak var picture: UIImageView?
   @IBOutlet weak var title: UILabel?
   @IBOutlet weak var length: UILabel?
   @IBOutlet weak var ingredientsDescr: UILabel?
   @IBOutlet weak var notation: UILabel?
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
