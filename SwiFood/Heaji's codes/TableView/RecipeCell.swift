//
//  RecipeCell.swift
//  SwiFood
//
//  Created by Jeon-heaji on 03/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    var food = ""
    var steps = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension RecipeCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return steps.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            cell.textLabel?.text = steps[indexPath.section]
        }
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = steps[indexPath.section]
   
        return cell
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("Headerstep\(section + 1)")
        return "step\(section + 1)"
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        print("Footerstep\(section + 1)")
        return "step\(section + 1)"
    }
    

}
extension RecipeCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 2 {
            return 0
        }
        return 30
//        return CGFloat.leastNormalMagnitude

    }
}

