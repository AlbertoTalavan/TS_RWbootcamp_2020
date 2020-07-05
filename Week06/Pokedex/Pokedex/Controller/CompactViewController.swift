///  Created by Alberto Talaván on 6/18/20.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class CompactViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  let pokemons = DataSource()
  let delegate = PokeCollectionViewDelegate(numberOfItemsPerRow: 3, interItemSpacing: 10)
  let whereAmI = WhereAmI.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = pokemons
    collectionView.delegate = delegate
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
    flowLayout.invalidateLayout()
    
    collectionView.reloadData()
  }
}


