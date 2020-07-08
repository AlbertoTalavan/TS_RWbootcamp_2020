///  Created by Alberto Talaván on 05/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class LargeViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  let pokemons = DataSource()
  let delegate = PokeCollectionViewDelegate(numberOfItemsPerRow: 3, interItemSpacing: 10)
  let whereAmI = WhereAmI.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = pokemons
    collectionView.delegate = delegate
  }
  
}
