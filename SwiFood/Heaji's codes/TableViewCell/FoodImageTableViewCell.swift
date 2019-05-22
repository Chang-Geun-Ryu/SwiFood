//
//  FoodImageTableViewCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 21/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class FoodImageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       contentView.backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
