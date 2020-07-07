///  Created by Alberto Talaván on 06/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import Foundation

struct Pokemon: Hashable {
  var pokemonID: Int = 0        //Int conforms to Hashable
  var pokemonName: String = ""
  var baseExp: Int = 0
  var height: Int = 0
  var weight: Int = 0
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(pokemonID)
  }
}

extension Pokemon {
  static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
    lhs.pokemonID == rhs.pokemonID
  }
}

