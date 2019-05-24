//
//  ViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 21/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
  let headerView = UIImageView()
  
  var foodData: FoodData!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerTableViewCell()
    configure()
  }
  
  private func configure() {
    headerView.image = UIImage(named: "ApplePieMain1")
    headerView.contentMode = .scaleAspectFit
    //        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
    headerView.backgroundColor = .white
//    let contenOffsetY = tableView.contentOffset.y
    //        headerView.bounds
    //        let height = tableView.estimatedRowHeight = contenOffsetY
    //        print(tableView.contentOffset.y)
    // 테이블뷰 델리게이트 y축움직일때 호출되는 func
    tableView.tableHeaderView = headerView
    
  }
  
  func registerTableViewCell() {
    tableView.register(UINib(nibName: "FoodMaterialTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodMaterial")
    tableView.register(UINib(nibName: "FoodIntroductionTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodIntroduction")
    tableView.register(UINib(nibName: "FoodImageTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodImage")
    tableView.register(UINib(nibName: "FoodRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodRecipe")
  }
  
  
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    switch indexPath.row {
    case 0:
      cell = tableView.dequeueReusableCell(withIdentifier: "FoodMaterial", for: indexPath)
    case 1:
      cell = tableView.dequeueReusableCell(withIdentifier: "FoodIntroduction", for: indexPath)
    case 2:
      cell = tableView.dequeueReusableCell(withIdentifier: "FoodImage", for: indexPath)
      
    case 3:
      cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecipe", for: indexPath)
      
    default:
      cell = UITableViewCell()
    }
    
    return cell
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(tableView.contentOffset.y)
    let contenOffsetY = tableView.contentOffset.y
    
    if contenOffsetY > 0 {
      return
    }
    
    let height = view.frame.width - contenOffsetY
    print("height", height)
    headerView.frame = CGRect(x: 0, y: contenOffsetY, width: view.frame.width, height: height )
    
  }
}

