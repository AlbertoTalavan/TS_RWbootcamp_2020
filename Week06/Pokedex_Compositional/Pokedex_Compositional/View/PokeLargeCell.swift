///  Created by Alberto Talaván on 06/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///
import UIKit

class PokeLargeCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: PokeCell.self)
  @IBOutlet weak var baseExpLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var pokeNameLabel: UILabel!
  @IBOutlet weak var pokeImage: UIImageView!
}
