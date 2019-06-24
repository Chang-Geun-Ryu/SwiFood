//
//  RecipeTitleCellCollectionViewCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class RecipeTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelTF: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    // MARK: - keyboard hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.text = "레시피 소개를 해주세요."
        textView.layer.cornerRadius = 10
        textView.font = UIFont(name: "Palatino", size: 20)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.textAlignment = .center
        
        textView.delegate = self
    }
    
}

// MARK: - TextViewDelegate
extension RecipeTitleCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if (textView.text == "레시피 소개를 해주세요." && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        } else {
            textView.text = "레시피 소개를 해주세요."
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "레시피 소개를 해주세요."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
