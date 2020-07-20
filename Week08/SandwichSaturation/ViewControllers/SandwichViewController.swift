///
///  Created by Jeff Rames on 20/7/20
///  Modified by Alberto Talaván
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  let defaults = UserDefaults.standard
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  
  let searchController = UISearchController(searchResultsController: nil)
  
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadSandwiches()
        
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
  
  func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
  
    let request: NSFetchRequest<Sandwich> = Sandwich.fetchRequest()
    let namePredicate = NSPredicate(format: "name CONTAINS [cd]%@", searchController.searchBar.text!)
    let saucePredicate = NSPredicate(format: "sandwichToSauce.sauceAmountString = %@", sauceAmount!.rawValue)
    var predicate = NSCompoundPredicate()//type: .and, subpredicates: [namePredicate])//, saucePredicate])
    
    if sauceAmount == .any {
      predicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate])
    } else {
      if isSearchBarEmpty {
        predicate = NSCompoundPredicate(type: .and, subpredicates: [saucePredicate])
      } else {
        predicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate, saucePredicate])
      }
    }

    request.predicate = predicate
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    request.sortDescriptors=[sortDescriptor]


    do {
      //try to retrieve data with CoreData from Sandwich Entity
      filteredSandwiches = try context.fetch(request)
    } catch let error as NSError{
      print("Error fetching data from context. \(error), \(error.userInfo)")
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
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteSandwich = UIContextualAction(style: .destructive, title: "delete"){
      (contextualAction, view, actionPerformed:(Bool) -> Void) in
        actionPerformed(true)
        self.context.delete(self.sandwiches[indexPath.row]) // first: deleting in the context
        self.sandwiches.remove(at: indexPath.row) //second: deleting in the array

        do {
          try self.context.save()  // third: saving context
        } catch {
          print("Unable to delete data: \(error)")
        }
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)  //fourth: updating the TableView

   }
   deleteSandwich.title = "delete Sandwich" //due to the cell is to small, the title is not displayed
   deleteSandwich.image = UIImage(systemName: "trash")
   tableView.deselectRow(at: indexPath, animated: true)
    
   return UISwipeActionsConfiguration(actions: [deleteSandwich])
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

// MARK: - Copying Json data file into Core Data
extension SandwichViewController {
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

    sandwichesJSON.forEach {
      let sandwich = Sandwich(context: context)
      let sauceAmount = SauceAmountCD(context: context)
      sandwich.name = $0.name
      sandwich.imageName = $0.imageName
      
      sauceAmount.sauceAmountString = $0.sauceAmount.rawValue
      
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
    
    let alert = UIAlertController (title: "Wellcome", message: """
This great app allows you to save your favorite  Sandwiches-Sauce combinations!
 There are some of them as example but you will be able to:
  - create new ones using the button for that purpose,
  - delete the ones you like swiping left
""", preferredStyle: .alert)
    let action = UIAlertAction(title: "Awesome 🤤", style: .default)
    alert.addAction(action)
    present(alert,animated: true)
  }
}
