//
//  FoodSubMeteralTableViewCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class FoodSubMaterialTableViewCell: UITableViewCell {
    
      @IBOutlet weak var foodNameLabel: UILabel!
      @IBOutlet weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
