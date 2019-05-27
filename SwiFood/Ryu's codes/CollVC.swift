//
//  collVC.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

extension Notification.Name {
  static let reload = Notification.Name("reload")
}

class CollVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  static var food: FoodData = FoodData()
  
  let searchController = UISearchController(searchResultsController: nil)
  //by hj
  
  let baseButton = UIButton()
  let dropList = ["최신순", "난이도순", "시간순"]
  var dropDownState = false
  var moveTop: NSLayoutConstraint?
  var moveState = false
  
  let padding: CGFloat = 16
//  var foodList: [FoodData] = []
//  var foodNames = ["MainApplePie", "MainChocolate", "MainDessert", "MainGrapePizza", "MainTarte"]
  let testButton = UIButton(type: .system)
  var constraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
//    testButton.setTitle("sssss", for: .normal)
    collectionView.addSubview(testButton)
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "레시피를 검색해 보세요."
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    
    navigationItem.titleView = UIImageView(image: UIImage(named: "mainLogo"))
    
    naviSet() // by HJ
    
    makeFoodList()
    
    setupCollectionViewLayout()
    
    setupCollectionView()
    
    setupNotification()
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    setupNoti()
    configure()
    autoLayout()
    makeDropButton()
  }
  
  private func configure() {
    baseButton.backgroundColor = .white
    baseButton.setTitle("추천순 ▼", for: .normal)
    baseButton.addTarget(self, action: #selector(baseButtonAction), for: .touchUpInside)
    baseButton.setTitleColor(.lightGray, for: .normal)
    baseButton.tintColor = .lightGray
    baseButton.titleLabel?.font = UIFont(name: "Palatino", size: 15)
    baseButton.layer.borderWidth = 0.5
    baseButton.layer.borderColor = UIColor.gray.cgColor
    baseButton.layer.cornerRadius = 5
    
    collectionView.addSubview(baseButton)
  }
  
  @objc private func baseButtonAction() {
    print("Hit")
    animate()
  }
  
  func animate() {
    moveState.toggle()
    
    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
      
      if self!.moveState {
        self?.dropMoveConstraint.forEach { $0?.priority = .defaultHigh }
        self?.dropButtons.forEach { $0.isHidden = false }
      } else {
        self?.dropMoveConstraint.forEach { $0?.priority = .defaultLow }
        self?.dropButtons.forEach { $0.isHidden = true }
      }
      self?.view.layoutIfNeeded()
    })
  }
  
  var dropButtons: [UIButton] = []
  var dropMoveConstraint: [NSLayoutConstraint?] = []
  private func makeDropButton() {
    for index in 0..<dropList.count {
      let tempButton = UIButton()
      tempButton.tag = index
      tempButton.isHidden = true
      tempButton.setTitle(dropList[index], for: .normal)
      tempButton.backgroundColor = .white
      tempButton.setTitleColor(.lightGray, for: .normal)
      tempButton.tintColor = .lightGray
      tempButton.titleLabel?.font = UIFont(name: "Palatino", size: 15)
      tempButton.layer.borderWidth = 0.5
      tempButton.layer.borderColor = UIColor.gray.cgColor
      tempButton.layer.cornerRadius = 5
      tempButton.addTarget(self, action: #selector(dropButtonAction), for: .touchUpInside)
      view.addSubview(tempButton)
      tempButton.translatesAutoresizingMaskIntoConstraints = false
      tempButton.centerXAnchor.constraint(equalTo: baseButton.centerXAnchor).isActive = true
      tempButton.widthAnchor.constraint(equalTo: baseButton.widthAnchor).isActive = true
      tempButton.heightAnchor.constraint(equalTo: baseButton.heightAnchor).isActive = true
      
      let defaultTop = tempButton.topAnchor.constraint(equalTo: baseButton.topAnchor)
      defaultTop.priority = UILayoutPriority(500)
      defaultTop.isActive = true
      
      
      switch index {
      case 0:
        moveTop = tempButton.topAnchor.constraint(equalTo: baseButton.topAnchor, constant: 30)
      case 1:
        moveTop = tempButton.topAnchor.constraint(equalTo: baseButton.topAnchor, constant: 60)
      case 2:
        moveTop = tempButton.topAnchor.constraint(equalTo: baseButton.topAnchor, constant: 90)
      default: break
      }
        moveTop?.priority = .defaultLow
        moveTop?.isActive = true
      dropButtons.append(tempButton)
      dropMoveConstraint.append(moveTop)
    }
  }
  // tag맞게 데이터를 정렬, reloaddata를 해줘야함
  @objc private func dropButtonAction(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      baseButton.setTitle(dropList[sender.tag] , for: .normal)
    case 1:
      baseButton.setTitle(dropList[sender.tag] , for: .normal)
    case 2:
      baseButton.setTitle(dropList[sender.tag] , for: .normal)
    default:
      break
    }
    animate()
  }
  
  
  private func autoLayout() {
    baseButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 350).isActive = true
    baseButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 265).isActive = true
    baseButton.translatesAutoresizingMaskIntoConstraints = false
    baseButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    baseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
  }
  
  
  func setupNoti() {
    NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: .reload, object: nil)
  }
  
  @objc func reload(_ noti: Notification) {
    print("reload")
    collectionView.reloadData()
  }
  
  func makeFoodList() {
  }
  
  func naviSet() {
    let barButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
    navigationItem.backBarButtonItem = barButton
    
    self.navigationController?.navigationBar.tintColor = .darkGray
    self.navigationController?.navigationBar.isTranslucent = false
    
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
    detailVC.food =   CollVC.food.list[index]   //foodList[index]
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
  
  // show detailVC
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showDetailVC(index: indexPath.item)
  }
  
  // header 본체
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
//    print("header Reload")
    return header
  }
  
  // header size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 340)
  }
  
  // cell count
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return CollVC.food.list.count
  }
  
  // cell
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
    let name = CollVC.food.list[indexPath.item].iconImage //foodList[indexPath.item].imageNames.first
    print("name: ", name)
    guard let image = CollVC.food.images[name] as? UIImage else {print("fail cell"); return cell  }
    cell.imageView.image = image
    cell.mainLabel.text = CollVC.food.list[indexPath.item].title
    cell.sensitivityLabel.text = CollVC.food.list[indexPath.item].sensitivity //foodList[indexPath.item].gamsungLabel
    cell.anotherInfo.text = CollVC.food.list[indexPath.item].info //foodList[indexPath.item].info
    
    //print("collectionView")
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
//    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}

extension CollVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}
