//
//  FoodImageTableViewCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class FoodImageTableViewCell: UITableViewCell {
    
      @IBOutlet weak var meterialImageView: UIImageView!
    
    var something = ""

//    var foodData: FoodData! {
//        didSet {
//            meterialImageView.image
//            
//        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        meterialImageView.contentMode = .scaleAspectFill
        

      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
