///  Created by Alberto Talaván on 05/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class WhereAmI {
  
  
  
  public static let shared = WhereAmI()

  private var position: TabBarPosition = .compactViewController
  
  private init() {}
  
  //MARK: - Setter
  func changePosition () {
    switch position {
      case .compactViewController:
        position = .largeViewController
      case .largeViewController:
        position = .compactViewController
    }
  }
  
  //MARK: - Getter
  func getPosition() -> TabBarPosition {
    return position
  }
}
