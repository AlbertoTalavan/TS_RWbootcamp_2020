///  Created by Alberto Talaván on 06/07/20
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class CompactViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  private var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!
  private let pokemons = PokemonGenerator.shared.generatePokemons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource(for: .compact)
    configureSnapShot()
  }
}

//MARK: - Compositional Layout
extension CompactViewController {
  func configureLayout() -> UICollectionViewCompositionalLayout {
    
    //item
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    //group
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.33))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    //section
    let section = NSCollectionLayoutSection(group: group)
    //section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
 }


//MARK: - Diffable Data Source
extension CompactViewController {
  func configureDataSource (for controller: Controller) {
    typealias PokeDexDataSource = UICollectionViewDiffableDataSource<Section, Pokemon>
    
    dataSource = PokeDexDataSource(collectionView: self.collectionView) { (collectionView, indexPath, pokemon) -> UICollectionViewCell? in
      
      if controller == .compact {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCellIdentifier", for: indexPath) as? PokeCell else {
        //fatalError("Cannot create new PokeCell")
        return nil
        }
        cell.pokeImage.image = UIImage(named: String(pokemon.pokemonID))
        cell.pokeNameLabel.text = pokemon.pokemonName
        cell.layer.cornerRadius = 10
        
        return cell
          
      }else if controller == .large {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeLargeCellIdentifier", for: indexPath) as? PokeLargeCell else {
          //fatalError("Cannot create new PokeLargeCell")
          return nil
        }
        cell.pokeImage.image = UIImage(named: String(pokemon.pokemonID))
        cell.pokeNameLabel.text = pokemon.pokemonName
        cell.baseExpLabel.text = String(pokemon.baseExp)
        cell.heightLabel.text = String(pokemon.height)
        cell.weightLabel.text = String(pokemon.weight)
        cell.layer.cornerRadius = 10
        
        return cell
        
      }else {
        return nil
      }
    }
  }

  
  func configureSnapShot() {
    var snapShot = NSDiffableDataSourceSnapshot<Section, Pokemon>()

    snapShot.appendSections([.main])
    snapShot.appendItems(pokemons)
    
    dataSource.apply(snapShot, animatingDifferences: false)
  }
}




