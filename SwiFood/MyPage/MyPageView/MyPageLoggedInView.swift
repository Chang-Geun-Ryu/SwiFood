//
//  MyPageLoggedInView.swift
//  SwiFood
//
//  Created by HongWeonpyo on 18/06/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

class MyPageLoggedInView: UIView {
  


    private let xibName = "MyPageLoggedInView"

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var myRecipeCollectionView: UICollectionView!
    @IBOutlet weak var mySavedRecipeCollectionView: UICollectionView!
  
  
  
  override func awakeFromNib() {
      myRecipeCollectionView.dataSource = self
      myRecipeCollectionView.delegate = self
      myRecipeCollectionView.register(UINib(nibName: "MyRecipeCell", bundle: nil), forCellWithReuseIdentifier: "MyRecipeCell")
  
      mySavedRecipeCollectionView.dataSource = self
      mySavedRecipeCollectionView.delegate = self
      mySavedRecipeCollectionView.register(UINib(nibName: "MyRecipeCell", bundle: nil), forCellWithReuseIdentifier: "MyRecipeCell")
    
  }

    override func layoutSubviews() {
      profileImageView.clipsToBounds = true
      profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

extension MyPageLoggedInView: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView == myRecipeCollectionView {
      return 10
    }
    if collectionView == mySavedRecipeCollectionView {
      return 2
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCell", for: indexPath) as! MyRecipeCell
    
    if collectionView == myRecipeCollectionView {

    }
    
    if collectionView == mySavedRecipeCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCell", for: indexPath) as! MyRecipeCell
    }
    return cell
  }
}

extension MyPageLoggedInView: UICollectionViewDelegate{
  
}

extension MyPageLoggedInView: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 100, height: 163)
  }
}

