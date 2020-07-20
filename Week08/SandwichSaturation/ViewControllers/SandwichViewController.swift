//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  let defaults = UserDefaults.standard //used to store the last search´s amount of sauce
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //CoreData
  
  let searchController = UISearchController(searchResultsController: nil)
//  var sandwiches = [SandwichData]()         //without CoreData
//  var filteredSandwiches = [SandwichData]() //without CoreData
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()

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
  
  func copyJsonToCoreData() {
      var sandwichesJSON = [SandwichData]()
    
      //we take the Json file with the array of predefined sandwiches
      guard let jsonPath = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else {
        print("###-json sandwiches file not found")
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let rawData = try Data(contentsOf: jsonPath)
        sandwichesJSON = try decoder.decode([SandwichData].self, from: rawData)
        print("###- Sandwiches loaded successfully!")
        
      } catch {
        print("###-Serialization error loading data: \(error)")
      }
      
    for sandwichJson in 0..<sandwichesJSON.count {
//      let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: context); #warning("This part was the key")
      let sandwich = Sandwich(context: context)
      let sauceAmount = SauceAmountCD(context: context)
      
      sandwich.name = sandwichesJSON[sandwichJson].name
      sandwich.imageName = sandwichesJSON[sandwichJson].imageName
      
      sauceAmount.sauceAmountString = sandwichesJSON[sandwichJson].sauceAmount.rawValue
      
      //giving value to the relationship between Sandwich and SauceAmountCD
      sandwich.sandwichToSauce = sauceAmount
      
      sandwiches.append(sandwich)
    }
      //now we have to save the predefined sandwiches array into Core Data
      do{
        try context.save()
      } catch let error as NSError {
        print("Error saving data: \(error), \(error.userInfo)")
      }

      //And finally we have to set the user default alreadyRun to true
      defaults.set(true, forKey: "AlreadyRun")
  }
  
  func loadSandwiches() {
    let alreadyRun: Bool
    alreadyRun = defaults.bool(forKey: "AlreadyRun") // if doesn´t exit => alreadyRun = false
    
    if !alreadyRun {
      copyJsonToCoreData()
    }
    
    let request: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
    
    do {
      //try to retrieve data with CoreData from Sandwich Entity
      sandwiches = try context.fetch(request)
    } catch let error as NSError{
      print("Error fetching data from context. \(error), \(error.userInfo)")
    }

    
    
  }

  func saveSandwich(_ sandwich: SandwichData) {
    //I can make the transformation SandwichData -> Sandwich here or
    //use Sandwich directly in AddSandwichViewController
    let sandwichCD = Sandwich(context: context)
    let sauceAmount = SauceAmountCD(context: context)
    
    sandwichCD.name = sandwich.name
    sandwichCD.imageName = sandwich.imageName
    sauceAmount.sauceAmountString = sandwich.sauceAmount.rawValue
    sandwichCD.sandwichToSauce = sauceAmount
    
    //add new sandwich
    sandwiches.append(sandwichCD)
    
    //save sandwich to core data
    do{
     try context.save()
    } catch let error as NSError {
      print("Error saving data: \(error), \(error.userInfo)")
    }
    
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
    filteredSandwiches = sandwiches.filter { (sandwich: Sandwich) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any // || sandwich.sauceAmount == sauceAmount

      if isSearchBarEmpty {
        return doesSauceAmountMatch
      } else {
        return doesSauceAmountMatch && sandwich.name.lowercased()
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
    cell.sauceLabel.text = sandwich.sandwichToSauce.sauceAmountString
    
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

//MARK: - Testing CoreData content
extension SandwichViewController {
  func whatHaveCoreDataInside() {
    /*
     let context = persistentContainer.viewContext
     let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
     let predicate = NSPredicate(format: "id = %@ && currentUserId = %@", id, userId)
     fetchRequest.predicate = predicate
     
     do {
     let user = try context.fetch(fetchRequest)
     if let user = user.first {
     // update if already exists
     user.id = id
     user.firstName = firstName
     user.lastName = lastName
     user.profilePhotoUrl = profilePhotoUrl
     
     saveContext()
     return user
     } else {
     // else create it
     let context = persistentContainer.viewContext
     let user = CDUser(context: context)
     user.id = id
     user.firstName = firstName
     user.lastName = lastName
     user.profilePhotoUrl = profilePhotoUrl
     
     saveContext()
     return user
     }
     } catch {
     print("Unable to save user entity.")
     return nil
     }
     */
  }
}

