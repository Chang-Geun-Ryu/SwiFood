//
//  StretchyHeaderLayout.swift
//  SwiFood
//
//  Created by CHANGGUEN YU on 24/05/2019.
//  Copyright © 2019 Swifood Team. All rights reserved.
//

import UIKit

protocol HeaderStrechy: class {
  func strechyFrame(offsetY: CGFloat)
}

class StretchyHeaderLayout: UICollectionViewFlowLayout {
  
  var delegate: HeaderStrechy?
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    layoutAttributes?.forEach({ (attributes) in
      
      if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
        
        guard let collectionView = collectionView else { return }
        
        let contentOffsetY = collectionView.contentOffset.y
        //print(contentOffsetY)
        
        if contentOffsetY > 0 {
          return
        }
        
        let width = collectionView.frame.width
        let height = attributes.frame.height - contentOffsetY
        
        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
        
        delegate?.strechyFrame(offsetY: contentOffsetY)
      }
    })
    
    return layoutAttributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
