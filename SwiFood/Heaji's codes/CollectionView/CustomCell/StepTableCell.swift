//
//  StepTableCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 19/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

protocol StepTableCelleDelegate: class {
    func variationCount(cell: StepTableCell)
    func imageAddGesture(gesture: UITapGestureRecognizer, cell: StepTableCell)
    func sendData(cell: StepTableCell, Text: String)

}


class StepTableCell: UITableViewCell {
    var delegate: StepTableCelleDelegate?
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handTapGesture(_:))))
        
        foodImageView.isUserInteractionEnabled = true
        textField.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)


    }
    // MARK: - keyboard hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Notification
    // 키보드 보이기 액션
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
            CGRect else { return }
            contentView.frame.origin.y = -self.textField.frame.origin.y
    }

    // 키보드 숨기기
    @objc func keyboardWillHide(_ sender: Notification) {
        contentView.frame.origin.y = 0
    }

    // MARK: - Gesture
    @objc func handTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.imageAddGesture(gesture: sender, cell: self)
        
    }
    @IBAction func minusBtn(_ sender: UIButton) {
        delegate?.variationCount(cell: self)
    }
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.sendData(cell: self, Text: sender.text ?? "")
    }
}

extension StepTableCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
