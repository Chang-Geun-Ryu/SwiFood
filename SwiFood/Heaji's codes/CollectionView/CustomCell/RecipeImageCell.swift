//
//  RecipeImageCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

protocol RecipeImageCellDelegate: class {
    func imageSelect(didTapButton button: UIButton)
}

class RecipeImageCell: UICollectionViewCell {
    
    weak var delegate: RecipeImageCellDelegate?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var completeFoodImage: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // MARK: - keyboard hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
   
    @IBAction func cameraBtnDidTap(_ sender: Any) {
        delegate?.imageSelect(didTapButton: sender as! UIButton)
    }

}

