///  Created by Alberto Talaván on 06/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///


import UIKit

class PokeCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: PokeCell.self)
  @IBOutlet weak var pokeImage: UIImageView!
  @IBOutlet weak var pokeNameLabel: UILabel!
  
}
