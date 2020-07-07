///  Created by Alberto Talaván on 6/18/20.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class DataSource {//: NSObject, UICollectionViewDataSource{
 /*
//  let whereAmI = WhereAmI.shared
  let pokemons = PokemonGenerator.shared.generatePokemons()
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemons.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var myCell: UICollectionViewCell
    
//    if whereAmI.getPosition() == .compactViewController {
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCellIdentifier", for: indexPath) as? PokeCell else { fatalError("Cell can not be created")}
//      myCell = configurePokeCell(for: cell, at: indexPath)
//      return myCell
//
//    } else if  whereAmI.getPosition() == .largeViewController {
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeLargeCellIdentifier", for: indexPath) as? PokeLargeCell else { fatalError("Large Cell can not be created")}
//      myCell = configurePokeLargeCell(for: cell, at: indexPath)
//      return myCell
//
//    } else {
//      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCellIdentifier", for: indexPath) as? PokeCell else { fatalError("Cell can not be created")}
//      myCell = configurePokeCell(for: cell, at: indexPath)
//      return myCell
//    }
    
    
     guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCellIdentifier", for: indexPath) as? PokeCell else { fatalError("Cell can not be created")}
     myCell = configurePokeCell(for: cell, at: indexPath)
      return myCell
    
    
  }
  
  func configurePokeCell(for cell: PokeCell, at indexPath: IndexPath) -> PokeCell{
    cell.pokeImage.image = UIImage(named: String(pokemons[indexPath.item].pokemonID))
    cell.pokeNameLabel.text = pokemons[indexPath.item].pokemonName
    
    cell.layer.cornerRadius = 10
    
    return cell
  }
  
  func configurePokeLargeCell(for cell: PokeLargeCell, at indexPath: IndexPath) -> PokeLargeCell {
    cell.pokeImage.image = UIImage(named: String(pokemons[indexPath.item].pokemonID))
    cell.pokeNameLabel.text = pokemons[indexPath.item].pokemonName
    cell.baseExpLabel.text = String(pokemons[indexPath.item].baseExp)
    cell.heightLabel.text = String(pokemons[indexPath.item].height)
    cell.weightLabel.text = String(pokemons[indexPath.item].weight)
    
    cell.layer.cornerRadius = 10
    
    return cell
  }
  */
}



