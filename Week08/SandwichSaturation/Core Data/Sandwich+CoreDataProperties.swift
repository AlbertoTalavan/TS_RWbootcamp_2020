///
///  Created by Alberto Talaván on 20/07/20.
///
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///


import Foundation
import CoreData


extension Sandwich {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sandwich> {
        return NSFetchRequest<Sandwich>(entityName: "Sandwich")
    }

    @NSManaged public var imageName: String
    @NSManaged public var name: String
    @NSManaged public var sandwichToSauce: SauceAmountCD

}
