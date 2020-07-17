//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  let defaults = UserDefaults.standard //used to store the last search´s amount of sauce
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichData]()
  var filteredSandwiches = [SandwichData]()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    loadSandwiches()
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
      //recovering last selection stored in UserDefaults
      searchController.searchBar.selectedScopeButtonIndex = defaults.integer(forKey: "SelectedScope")
    searchController.searchBar.delegate = self

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func loadSandwichesJSON() {
    guard let jsonPath = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else {
      print("###-json sandwiches file not found")
      return
    }
    
    do {
      let decoder = JSONDecoder()
      let rawData = try Data(contentsOf: jsonPath)
      sandwiches = try decoder.decode([SandwichData].self, from: rawData)
      print("###- Sandwiches loaded successfully!")
      
    } catch {
      print("###-Serialization error loading data: \(error)")
    }  
  }
  
  func loadSandwiches() {
//    let sandwichArray = [SandwichData(name: "Bagel Toast", sauceAmount: .none, imageName: "sandwich1"),
//                         SandwichData(name: "Bologna", sauceAmount: .none, imageName: "sandwich2"),
//                         SandwichData(name: "Breakfast Roll", sauceAmount: .none, imageName: "sandwich3"),
//                         SandwichData(name: "Club", sauceAmount: .none, imageName: "sandwich4"),
//                         SandwichData(name: "Sub", sauceAmount: .none, imageName: "sandwich5"),
//                         SandwichData(name: "Steak", sauceAmount: .tooMuch, imageName: "sandwich6"),
//                         SandwichData(name: "Dunno", sauceAmount: .tooMuch, imageName: "sandwich7"),
//                         SandwichData(name: "Torta", sauceAmount: .tooMuch, imageName: "sandwich8"),
//                         SandwichData(name: "Ham", sauceAmount: .tooMuch, imageName: "sandwich9"),
//                         SandwichData(name: "Lettuce", sauceAmount: .tooMuch, imageName: "sandwich10")]
//    sandwiches.append(contentsOf: sandwichArray)
    
    loadSandwichesJSON()
    
    //if firstRun load sandwiches from Json file
    //else load sandwiches from coreData
    
  }

  func saveSandwich(_ sandwich: SandwichData) {
    sandwiches.append(sandwich)
    //save sandwich to core data
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount

      if isSearchBarEmpty {
        return doesSauceAmountMatch
      } else {
        return doesSauceAmountMatch && sandwhich.name.lowercased()
          .contains(searchText.lowercased())
      }
    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.description

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  
  
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    
    //saving the selectedScope into UserDefaults
    defaults.set(selectedScope, forKey: "SelectedScope")
    
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

