//
//  FoodIntroductionTableViewCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//
// 24일 수정

import UIKit

class FoodIntroductionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var tagBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("FoodIntroductionTableViewCell")
        contentView.backgroundColor = #colorLiteral(red: 0.9302537997, green: 0.9413712117, blue: 1, alpha: 1)
        
    }
    
    @IBAction func commentButtonDidTap(_ sender: Any) {
        print("comment")
        
        NotificationCenter.default.post(name: NSNotification.Name("CommentTap"), object: nil , userInfo: [ "cell" : self])
        
    }
    
    @IBAction func tagDidTap(_ sender: Any) {
        print("tagDidTap")
        NotificationCenter.default.post(name: NSNotification.Name("tagDidTap"), object: nil , userInfo: [ "cell" : self])
        
         tagBtn.isSelected.toggle()

    }
}
