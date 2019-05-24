//
//  ViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
  let headerView = UIImageView()
  
  var foodData: FoodData!
  var food: Food?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
      
        registerTableViewCell()
        configure()
        
    }
    
    private func configure() {
        noti()
    }
  func noti(){
        NotificationCenter.default.addObserver(self, selector: #selector(commentVC), name: NSNotification.Name(rawValue: "CommentTap"), object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(alertVC), name: NSNotification.Name(rawValue: "tagDidTap"), object: nil)
    }
    @objc private func alertVC(_ sender: Notification) {
        print("alertVC")
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 10, y: -50, width: view.frame.width - 20, height: 80)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        
        let image = UIImageView()
        image.image = UIImage(named: "tag6")
        image.translatesAutoresizingMaskIntoConstraints = false
       
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "레시피가 책갈피에 보관되었습니다."
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "책갈피 리스트를 확인해보세요."
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        view.addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 20),
            image.widthAnchor.constraint(equalToConstant: 35),
            
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 25),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            ])
        
        UIView.animate(withDuration: 0.5) {
            containerView.frame.origin = CGPoint(x: 10, y: 80)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                UIView.animate(withDuration: 0.5, animations: {
                    containerView.frame.origin = CGPoint(x: 10, y: -90)
                })
            })
        }
        
    }
    
    @objc private func commentVC(_ sender: Notification){
        print("comeentVC")

        let commentVC = CommentViewController()
        commentVC.food = food
        print("present Before")
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "FoodIntroductionTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodIntroductionTableViewCell")
        tableView.register(UINib(nibName: "FoodMaterialTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodMaterialTitleTableViewCell")
        tableView.register(UINib(nibName: "FoodSubMaterialTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodSubMaterialTableViewCell")
        tableView.register(UINib(nibName: "FoodImageTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodImageTableViewCell")
        tableView.register(UINib(nibName: "FoodRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodRecipeTableViewCell")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    // section 나눠서 section당 몇개가 들어갈지
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let food = food else {print("food is empty"); return 0}
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return food.foodMeterial.count + 1 // foodMaterial
        case 3:
            return food.meterialImages.count
        case 4:
            return food.recipe.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let food = food else {print("food is empty"); return UITableViewCell()}
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.selectionStyle = .none
            cell.headerImageView.image = UIImage(named: food.iconImage) ?? (CollVC.food.images[food.iconImage] ?? nil)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodIntroductionTableViewCell", for: indexPath) as!
            FoodIntroductionTableViewCell
            cell.selectionStyle = .none
            cell.foodNameLabel.text = food.title
            cell.levelLabel.text = food.level
//            cell.commentLabel.text = food.comment[indexPath.row]
            return cell
        case 2:
            print(indexPath.row)
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodMaterialTitleTableViewCell", for: indexPath) as! FoodMaterialTitleTableViewCell
                cell.selectionStyle = .none
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodSubMaterialTableViewCell", for: indexPath) as! FoodSubMaterialTableViewCell
            cell.selectionStyle = .none
            cell.foodNameLabel.text = food.foodMeterial[indexPath.row - 1].0
            cell.numberLabel.text = food.foodMeterial[indexPath.row - 1].1
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodImageTableViewCell", for: indexPath) as! FoodImageTableViewCell
            cell.selectionStyle = .none
            cell.meterialImageView.image = UIImage(named: food.meterialImages[indexPath.row]) ?? (CollVC.food.images[food.meterialImages[indexPath.row]] ?? nil)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodRecipeTableViewCell", for: indexPath) as! FoodRecipeTableViewCell
            cell.selectionStyle = .none
            cell.recipeLabel.text = food.recipe[indexPath.row]
            return cell
        
        default:
            return UITableViewCell()
        }
        
    }

}
