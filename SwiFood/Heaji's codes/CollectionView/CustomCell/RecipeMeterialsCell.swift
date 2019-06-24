//
//  TestCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 18/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class RecipeMeterialsCell: UICollectionViewCell {
    
    private var initialValue = 1
    var meterial = [Meterial]()
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self

        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TestCellTable", bundle: nil), forCellReuseIdentifier: "CellId")
        tableView.rowHeight = 80

    }
    // MARK: - keyboard hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    
    @IBAction func addBtnDidTap(_ sender: UIButton) {
        
        meterial.append(Meterial(meterialName: "", amount: ""))
//        print("count: ", meterial.count)
        tableView.reloadData()
    }
    
}
extension RecipeMeterialsCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("meterial.count: ", meterial.count)
        return meterial.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TestCellTable
        cell.delegate = self
        cell.selectionStyle = .none
        cell.meterialsTextfield.text = meterial[indexPath.row].meterialName
        cell.amountTextfield.text = meterial[indexPath.row].amount
        return cell
    }
}

extension RecipeMeterialsCell: TestCellTableDelegate {
    
    func sendText(cell: TestCellTable, Text: String) {
        guard let cellIdx = tableView.indexPath(for: cell) else { return }
        let meterialsText = cell.meterialsTextfield.text
        let amountText = cell.amountTextfield.text
        
        meterial[cellIdx.row].meterialName = meterialsText ?? ""
        meterial[cellIdx.row].amount = amountText ?? ""
    }
    
    func removeIdx(cell: TestCellTable) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if meterial.count == 1 { return }
        
        meterial.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
}
