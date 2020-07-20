//
//  SauceAmountCD+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Alberto Talaván on 20/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension SauceAmountCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SauceAmountCD> {
        return NSFetchRequest<SauceAmountCD>(entityName: "SauceAmountCD")
    }

    @NSManaged public var sauceAmountString: String?
    @NSManaged public var sauceToSandwich: Sandwich

}
