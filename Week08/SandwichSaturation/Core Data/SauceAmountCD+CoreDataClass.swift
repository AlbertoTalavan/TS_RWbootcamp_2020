//
//  SauceAmountCD+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Alberto Talaván on 20/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

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
