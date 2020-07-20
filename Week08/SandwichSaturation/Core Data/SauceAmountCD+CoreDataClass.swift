///
///  Created by Alberto Talaván on 20/07/20.
///
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///


import Foundation
import CoreData

@objc(SauceAmountCD)
public class SauceAmountCD: NSManagedObject {
  var sauceAmount: SauceAmount {
    get {
      guard let sauceAmountString = self.sauceAmountString,
        let amount = SauceAmount(rawValue: sauceAmountString)
        else { return .none}
      
      return amount
    }
    
    set {
      self.sauceAmountString = newValue.rawValue
    }
  }
}
