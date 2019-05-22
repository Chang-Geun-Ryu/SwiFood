//
//  MainVC.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 21/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PinterestLayout())
  private var imageArray: [UIImage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    makeImage()
    configure()
    autoLayout()
  }
  
  private func makeImage() {
    for i in 0...5 {
      let image = UIImage(named: "\(i)")
      imageArray.append(image!)
    }
  }
  
  private func configure() {
    if let layout = collectionView.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    let aView = UIView()
    aView.backgroundColor = .red
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "image")
    collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    view.addSubview(collectionView)
    
    
  }
  
  private func autoLayout() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}

extension MainVC: UICollectionViewDataSource, PinterestLayoutDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
    
    cell.imageView.image = imageArray[indexPath.row]
    print("?")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    print("!")
    return imageArray[indexPath.item].size.height
  }
  
  //Row for each TV show
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    print("aaaaa")
    return CGSize(width: view.frame.width, height: 120)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    print("1111")
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! Header
    
    return header
  }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
  // select
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}

class Header: UICollectionViewCell  {
  
  override init(frame: CGRect)    {
    super.init(frame: frame)
    setupHeaderViews()
  }
  
  let dateLabel: UILabel = {
    let title = UILabel()
    title.text = "Today"
    title.textColor = .gray
    title.backgroundColor = .black
    title.font = UIFont(name: "Montserrat", size: 17)
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  func setupHeaderViews()   {
    addSubview(dateLabel)
    
    dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
