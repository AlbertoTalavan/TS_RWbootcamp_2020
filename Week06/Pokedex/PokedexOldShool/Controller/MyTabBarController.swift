

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
  
  let whereAmI = WhereAmI.shared
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    if item.title == "Compact View" {
      if whereAmI.getPosition() != .compact {
        whereAmI.changePosition()
      }
    } else if item.title == "Large View" {
      if whereAmI.getPosition() != .large {
        whereAmI.changePosition()
      }
    }else {
      if whereAmI.getPosition() != .compact {
        whereAmI.changePosition()
      }
    }
  }
  
}

