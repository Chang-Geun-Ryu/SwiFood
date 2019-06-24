//
//  RecipeOrderCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 10/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

protocol RecipeStepCellDelegate: class {
    func alertPresent(saveButton button: UIButton)
    func imageAddGesture(gesture: UITapGestureRecognizer, section: Int?)
}


class RecipeStepCell: UICollectionViewCell {
    // stpe cell -> 초기화 1
    weak var delegate: RecipeStepCellDelegate?
    
    private var initialValue = 1
//    var recipes = Recipes.shared.recipes
    
    
    // MARK: -  Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "StepTableCell", bundle: nil), forCellReuseIdentifier: "CellId")
        
    }
    
    // MARK: - keyboard hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.contentView.endEditing(true)
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        Recipes.shared.recipes.append(Recipe(recipeImage: UIImage(named: "img"), recipeDiscription: ""))
        print("@@@@@@ RecipesCount: ", Recipes.shared.recipes.count)
        tableView.reloadData()
    }
    
    @IBAction func saveButtonDidTap(_ sender: Any) {
        delegate?.alertPresent(saveButton: sender as! UIButton)
    }
}

extension RecipeStepCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Recipes.shared.recipes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! StepTableCell
        cell.delegate = self
        cell.textField.text = Recipes.shared.recipes[indexPath.section].recipeDiscription
        cell.foodImageView?.image = Recipes.shared.recipes[indexPath.section].recipeImage
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension RecipeStepCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Step\(section + 1)"
    }
    
}

extension RecipeStepCell: StepTableCelleDelegate {
    func imageAddGesture(gesture: UITapGestureRecognizer, cell: StepTableCell) {
        let section = tableView.indexPath(for: cell)?.section
        delegate?.imageAddGesture(gesture: gesture, section: section)
        
    }
    
    func sendData(cell: StepTableCell, Text: String) {
        
        guard let cellIdx = tableView.indexPath(for: cell) else { return }
        let cellImg = cell.foodImageView.image
        let cellText = cell.textField.text
        
        Recipes.shared.recipes[cellIdx.section].recipeImage = cellImg
        Recipes.shared.recipes[cellIdx.section].recipeDiscription = cellText ?? ""
    }
    
    func variationCount(cell: StepTableCell) {

        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if Recipes.shared.recipes.count == 1 { return }
    
        Recipes.shared.recipes.remove(at: indexPath.section)
        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        tableView.reloadData()
    }
    
}


extension RecipeStepCell: RecipeCollectionViewControllerDelegate {
    func reload() {
        tableView.reloadData()
    }
}
