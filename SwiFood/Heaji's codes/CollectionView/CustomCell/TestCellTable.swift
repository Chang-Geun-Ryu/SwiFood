//
//  TestCellTable.swift
//  SwiFood
//
//  Created by Jeon-heaji on 18/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit
// 재료 추가에는 이미지 없음
protocol TestCellTableDelegate: UICollectionViewCell {
    func removeIdx(cell:TestCellTable )
    func sendText(cell: TestCellTable, Text: String)
}

class TestCellTable: UITableViewCell {
    
    var delegate: TestCellTableDelegate?

    @IBOutlet weak var meterialsTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        meterialsTextfield.delegate = self
        amountTextfield.delegate = self
        
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
    
    // MARK: - Notification
    // 키보드 보이기 액션
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
            CGRect else { return }
        contentView.frame.origin.y = -30
//        contentView.frame.origin.y = keyboardFrame.height
        
    }
    
    // 키보드 숨기기
    @objc func keyboardWillHide(_ sender: Notification) {
        contentView.frame.origin.y = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func textfieldEditingChanged(_ sender: UITextField) {
        delegate?.sendText(cell: self, Text: sender.text ?? "")
    }
    
    @IBAction func minusBtn(_ sender: UIButton) {
        delegate?.removeIdx(cell: self)
        
    }
}
extension TestCellTable: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
