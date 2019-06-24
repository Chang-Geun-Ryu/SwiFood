//
//  ViewController.swift
//  SwiFood
//
//  Created by Jeon-heaji on 24/05/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    // MARK: - Properties
    
    let headerView = UIImageView()
    
    var foodData: FoodData!
    var food: Food?
    
    // MARK: - VC life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview register
        registerTableViewCell()
        
        // notification configuration
        notificationConfiguration()
        
        // configure view components
        configure()
        
    }
    
    // MARK: - Configuration
    
    private func configure() {
        title = ""
    }
    
    private func notificationConfiguration(){
        NotificationCenter.default.addObserver(self, selector: #selector(commentVC), name: NSNotification.Name(rawValue: "CommentTap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertVC), name: NSNotification.Name(rawValue: "tagDidTap"), object: nil)
    }
    
    private func registerTableViewCell() {
        tableView.register(UINib(nibName: "FoodIntroductionTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodIntroductionTableViewCell")
        tableView.register(UINib(nibName: "FoodMaterialTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodMaterialTitleTableViewCell")
        tableView.register(UINib(nibName: "FoodSubMaterialTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodSubMaterialTableViewCell")
        tableView.register(UINib(nibName: "FoodImageTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodImageTableViewCell")
        tableView.register(UINib(nibName: "FoodRecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodRecipeTableViewCell")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
    }
    
    // MARK: Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // section 1 :  헤더사진 + 정보 + 재료 섹션
        // section 2 :  음식사진
        // default (other) : food!.recipe.count
        
        // section1 + section2 + other(recipe)
        return 2 + food!.recipe.count
    }
    
    
    // section 나눠서 section당 몇개가 들어갈지
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let food = food else {print("food is empty"); return 0}
        switch section {
        // section 1 :  헤더사진 + 정보 + 재료 섹션
        case 0:
            return 3 + food.foodMeterial.count
        // section 2 :  음식사진들
        case 1:
            return food.meterialImages.count
        // 레시피 스텝 하나하나
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let food = food else {print("food is empty"); return UITableViewCell()}
        switch indexPath.section {
        // 헤더사진 + 정보 + 재료 섹션
        case 0:
            
            switch indexPath.row {
            // 헤더 음식 사진
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.selectionStyle = .none
                cell.headerImageView.image = UIImage(named: food.iconImage) ?? (CollVC.food.images[food.iconImage] ?? nil)
                return cell
            // 음식 소개
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodIntroductionTableViewCell", for: indexPath) as!
                FoodIntroductionTableViewCell
                cell.selectionStyle = .none
                cell.foodNameLabel.text = food.title
                cell.levelLabel.text = food.level
                //            cell.commentLabel.text = food.comment[indexPath.row]
                return cell
            // FoodMaterial 레이블
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodMaterialTitleTableViewCell", for: indexPath) as! FoodMaterialTitleTableViewCell
                cell.selectionStyle = .none
                return cell
            // 음식재료들 숫자대로 셀 생성
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FoodSubMaterialTableViewCell", for: indexPath) as! FoodSubMaterialTableViewCell
                cell.selectionStyle = .none
                cell.foodNameLabel.text = food.foodMeterial[indexPath.row - 3].0 // 위에 셀들을 제외한 숫자로 배열 접근하기
                cell.numberLabel.text = food.foodMeterial[indexPath.row - 3].1
                return cell
            }
            
        // 사진 섹션
        case 1 :
            // 사진 수 만큼 셀 생성
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodImageTableViewCell", for: indexPath) as! FoodImageTableViewCell
            cell.meterialImageView.image = UIImage(named: food.meterialImages[indexPath.row])
            return cell
            
        // 레시피 섹션
        default:
            // 레시피 숫자만큼 섹션 생성
            let cell: UITableViewCell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell"){
                cell.textLabel?.text = food.recipe[indexPath.section - 2] // 레시피는 1섹션당 1로우이기 떄문에 indexPath.section으로 접근
            }
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            print(indexPath.section)
            cell.textLabel?.text = food.recipe[indexPath.section - 2]
            return cell
        }
        
        
    }
    
    // 레시피 배열 인덱스와 일치 하도록 - 1 해주기
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Step \(section - 1)"
    }
    
    // 헤더 높이 조절 및 레시피 섹션만 섹션 드러나게 하기
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 1 {
            return 40       // 높이
        }
        return 0
    }
    
    // MARK: - Action
    
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
}
