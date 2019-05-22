//
//  collVC.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 21/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class CollVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  let searchController = UISearchController(searchResultsController: nil)
  let padding: CGFloat = 16
  var foodList: [FoodData] = []
  var foodNames = ["MainApplePie", "MainChocolate", "MainDessert", "MainGrapePizza", "MainTarte"]
  let testButton = UIButton(type: .system)
  var constraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    testButton.setTitle("sssss", for: .normal)
    collectionView.addSubview(testButton)
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "레시피를 검색해 보세요."
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    
    navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
    
    makeFoodList()
    
    setupCollectionViewLayout()
    
    setupCollectionView()
    
    setupNotification()
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  func makeFoodList() {
    foodNames.forEach { [weak self] in
      let food = FoodData()
      food.imageNames.append($0)
      self?.foodList.append(food)
    }
  }
  
  func setupCollectionView() {
    collectionView.backgroundColor = .white
    
    collectionView.contentInsetAdjustmentBehavior = .never
    
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    
    collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
  }
  
  func setupNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(tapHeader(_:)), name: .headerTap, object: nil)
  }
  
  // header tap func
  @objc func tapHeader(_ noti: Notification) {
    guard let currentImage = noti.userInfo?["currentImage"] as? Int else { return }
    
    showDetailVC(index: currentImage)
  }
  
  func showDetailVC(index: Int) {
    let detailVC = DetailViewController()
    detailVC.foodData = foodList[index]
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  // collection view operating //
  func setupCollectionViewLayout() {
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.sectionInset = .init(top: 50 + padding, left: padding, bottom: 50 + padding, right: padding)
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showDetailVC(index: indexPath.item)
  }
  
  // header 본체
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
    
    return header
  }
  
  // header size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 340)
  }
  
  // cell count
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return foodList.count
  }
  
  // cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
    let name = foodList[indexPath.item].imageNames.first
    cell.imageView.image = UIImage(named: name ?? "")
    cell.mainLabel.text = name ?? ""
    cell.sensitivityLabel.text = foodList[indexPath.item].gamsungLabel
    cell.anotherInfo.text = foodList[indexPath.item].info
    return cell
  }
  
  // cell items
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = view.frame.width / 2 - padding * 2 + 5
    return .init(width: size, height: size + 50)
  }
}


extension CollVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

extension CollVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}
