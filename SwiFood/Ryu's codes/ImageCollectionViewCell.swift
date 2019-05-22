//
//  ImageCollectionViewCell.swift
//  TestPinterest
//
//  Created by Kira on 21/05/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  let imageView = UIImageView()
  let mainLabel = UILabel()
  let sensitivityLabel = UILabel()
  let anotherInfo = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configuer()
    autolayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configuer() {
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 10
    contentView.addSubview(imageView)
    
    sensitivityLabel.text = "text"
    sensitivityLabel.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
    contentView.addSubview(sensitivityLabel)
    
    mainLabel.text = "text"
    mainLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    contentView.addSubview(mainLabel)
    
    anotherInfo.text = "text"
    anotherInfo.font = UIFont.systemFont(ofSize: 15, weight: .ultraLight)
    contentView.addSubview(anotherInfo)
    
  }
  
  private func autolayout() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    
    sensitivityLabel.translatesAutoresizingMaskIntoConstraints = false
    sensitivityLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
    sensitivityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    sensitivityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    sensitivityLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    
    mainLabel.translatesAutoresizingMaskIntoConstraints = false
    mainLabel.topAnchor.constraint(equalTo: sensitivityLabel.bottomAnchor, constant: 2).isActive = true
    mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    mainLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    anotherInfo.translatesAutoresizingMaskIntoConstraints = false
    anotherInfo.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 2).isActive = true
    anotherInfo.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5).isActive = true
    anotherInfo.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
    anotherInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    anotherInfo.heightAnchor.constraint(equalToConstant: 15).isActive = true
  }
  
  
}
