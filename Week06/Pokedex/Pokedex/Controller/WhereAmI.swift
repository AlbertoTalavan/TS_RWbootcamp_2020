

import UIKit

class WhereAmI {
  
  enum TabBarPosition {
    case compact,large
  }
  
  public static let shared = WhereAmI()

  private var position: TabBarPosition = .compact
  
  private init() {}
  
  //MARK: - Setter
  func changePosition () {
    switch position {
      case .compact:
        position = .large
      case .large:
        position = .compact
    }
  }
  
  //MARK: - Getter
  func getPosition() -> TabBarPosition {
    return position
  }
}
