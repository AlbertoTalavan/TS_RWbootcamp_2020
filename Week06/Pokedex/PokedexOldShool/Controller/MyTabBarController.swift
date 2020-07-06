///  Created by Alberto Talaván on 6/18/20.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
  
  let whereAmI = WhereAmI.shared
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item.title == "Compact View" {
      if whereAmI.getPosition() != .compactViewController {
        whereAmI.changePosition()
      }
    } else if item.title == "Large View" {
      if whereAmI.getPosition() != .largeViewController {
        whereAmI.changePosition()
      }
    }else {
      if whereAmI.getPosition() != .compactViewController {
        whereAmI.changePosition()
      }
    }
  }
  
}

