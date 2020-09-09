//
//  Model.swift
//  Compatibility_Slider
//
//  Created by Alberto Talaván on 19/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class CompatibilityGame {
   
   private var person1 = Person(id: 1, items: [:])
   private var person2 = Person(id: 2, items: [:])
   
   private var compatibilityItems = [String]() //["Cats", "Dogs"] //default value
   private var currentItemIndex = 0
   
   //MARK: list of different topics
   private let subjects = ["Cats", "Dogs", "Thai food", "Contact Sports", "Theme parks",
                           "Ice creams", "Mountain" , "Beach", "Snow in winter", "Babies",
                           "Rolling", "Surf", "Costumes", "Maths", "Philosophy"]
   
   private var howManyTopics = 2
   
   
   //MARK: - Compatibility
   func calculateCompatibility() -> String {
       // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
       var percentagesForAllItems: [Double] = []

       for (key, person1Rating) in person1.items {
           let person2Rating = person2.items[key] ?? 0
           let difference = abs(person1Rating - person2Rating)/5.0
           percentagesForAllItems.append(Double(difference))
       }

       let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
       let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
//       print(matchPercentage, "%")
       let matchString = 100 - (matchPercentage * 100).rounded()
      
       return "\(matchString)"
   }
   
   private func assignCompatibilitySubjects(){
      var subjectsChosen = [String]()  //stores the subjects already selected
      var subjectsFree = subjects      //stores the subjects we still have to choose
            //same as subjectsFree.append(contentsOf: subjects.map { $0 })
      
      var randomIndex = 0
      for _ in 1...howManyTopics {
         randomIndex = Int.random(in: 0 ..< subjectsFree.count)
         subjectsChosen.append(subjectsFree.remove(at: randomIndex))  //with remove(at:) we assure we will not have repeated topics
      }
      compatibilityItems.append(contentsOf: subjectsChosen)
   }
   
   
   //MARK: - Getters/Setters
      //getters
   func getPerson1() -> Person {
      person1
   }
   
   func getPerson2() -> Person {
      person2
   }
   
   func getHowManyCompatibilityItems() -> Int {
      compatibilityItems.count
   }
   
   func getCompatibilityItem() -> String {
      compatibilityItems[currentItemIndex]
   }
   
   func getCurrentItemIndex() -> Int {
      currentItemIndex
   }
   
      //setters
   func updateCurrentItemIndex() {
      compatibilityItems.count > (currentItemIndex + 1) ? (currentItemIndex += 1) : resetCurrentItemIndex()
   }
   
   private func resetCurrentItemIndex() {
      currentItemIndex = 0
   }
   
   private func resetCompatibilityItems() {
      compatibilityItems.removeAll()
   }
   
   func updatePerson(who player: Person, new item: [String: Float]) {

      player.items.updateValue(item.values.first!, forKey: item.keys.first!)
   }
   
   private func resetPerson(who person: Person) {
      person.items.removeAll()
   }
   
   func setTopicsNumber(howMany value: Int) {
      howManyTopics = value
         //print("how many topics = \(howManyTopics)")
   }
   
   
   //MARK: - Reset Model Values
   func reset () {
      resetPerson(who: person1)        //cleaning items
      resetPerson(who: person2)        //cleaning items
      resetCurrentItemIndex()          //sets current index to Zero
      setTopicsNumber(howMany: Int.random(in: 2...5))      //sets current index to One
      resetCompatibilityItems()        //remove All elements to prevent "index ouf of range"
      assignCompatibilitySubjects()    //choose randomly "howManysubjects" different subjects
   }

}

   //MARK: - Only for testing

#if DEBUG
///  due to #if DEBUG the following code will
///  NOT be shipped to production.

   extension CompatibilityGame {
      //I use strange methods´ names trying to avoid using those ones in production code
      func assignCSHC(_ password: String) {
         if password == "just for testing purposes " {
            compatibilityItems = []
            compatibilityItems = ["Dogs", "Cats", "Beach", "Surf", "Mountain"]
         }
      }
      
      func alternativeTestingReset(_ password: String) {
         if password == "just for testing purposes " {
         resetPerson(who: person1)        //cleaning items
         resetPerson(who: person2)        //cleaning items
         resetCurrentItemIndex()          //sets current index to Zero
         setTopicsNumber(howMany: 4)      //sets current index to One
         resetCompatibilityItems()        //remove All elements to prevent "index ouf of range"
         assignCSHC("just for testing purposes ")
         }
      }
      
      func setCII (_ password: String, _ value: Int) {
         if password == "just for testing purposes " {
         currentItemIndex = value
         }
      }
      
      func resetCI(_ password: String) {
         if password == "just for testing purposes " {
            resetCompatibilityItems()
         }
      }
      
      func sp(_ password: String, _ p: Person) {
         if password == "just for testing purposes " {
            resetPerson(who: person1)
            person1 = p
         }
      }
      
      func testTN(_ password: String) -> Int? {
         if password == "just for testing purposes " {
            return howManyTopics
         }
         return nil
      }
   }

#endif

