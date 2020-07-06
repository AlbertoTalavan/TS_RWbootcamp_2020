///  Created by Alberto Talaván on 6/18/20.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class PokeCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  let whereAmI = WhereAmI.shared
  
  let numberOfItemPerRow: CGFloat
  let interItemSpacing: CGFloat
  var leftInset = CGFloat(10)
  var rightInset = CGFloat(10)
  
  init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
    self.numberOfItemPerRow = numberOfItemsPerRow
    self.interItemSpacing = interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxWidth = UIScreen.main.bounds.width
    let totalSpacing: CGFloat
    
    if whereAmI.getPosition() == .compactViewController {
      leftInset = CGFloat(10)
      rightInset = CGFloat(10)
    } else if whereAmI.getPosition() == .largeViewController {
      leftInset = CGFloat(50)
      rightInset = CGFloat(50)
    }else {
      leftInset = CGFloat(10)
      rightInset = CGFloat(10)
    }
    
    totalSpacing = interItemSpacing * numberOfItemPerRow + leftInset + rightInset
    
    let itemWidth = (maxWidth - totalSpacing)/numberOfItemPerRow
   
    return CGSize(width: itemWidth, height: itemWidth)

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    return interItemSpacing
  } 
}
