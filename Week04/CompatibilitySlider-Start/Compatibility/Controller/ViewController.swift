//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Alberto Talaván on 6/16/20.

//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var compatibilityItemLabel: UILabel!
   @IBOutlet weak var slider: UISlider!
   @IBOutlet weak var questionLabel: UILabel!
   
   @IBOutlet weak var leftStar: UIImageView!
   @IBOutlet weak var rightStar: UIImageView!
   
   
   @IBOutlet weak var nextButton: UIButton!
   
   var game: CompatibilityGame?
   
   var currentPerson: Person?
  
   //MARK: - View Controller Methods
   override func viewDidLoad() {
      super.viewDidLoad()
      
      game = CompatibilityGame()
      
      setUpUIElements()
      restart()
      
   }
   
   //MARK: - Actions
   @IBAction func didPressNextItemButton(_ sender: Any) {
      updateGame()
   }
   
   
   //MARK: - Game Logic
   func updateGame() {
      
      guard let game = game else { print("game not instantiated at button pressed"); return }
      
      //gets the compatibilityItem[currentIndex]
      let currentItem = game.getCompatibilityItem()
      
      guard let currentPerson = currentPerson else { print("no person at pressed button"); return}
      
      if currentPerson.id == 1 {
         //update currentPerson with the new data
         game.updatePerson(who: currentPerson, new: [currentItem : slider.value])
         
         //update needed game properties
         game.updateCurrentItemIndex()
         
         //is it time to change the player?
         game.getPerson1().items.count < game.getHowManyCompatibilityItems() ? (self.currentPerson = game.getPerson1()) : (self.currentPerson = game.getPerson2())
         
         //update UI
         updateUI(for: self.currentPerson!)
         
      }else {
         // current person is person 2
         //update currentPerson with the new data
         game.updatePerson(who: currentPerson, new: [currentItem : slider.value])

         //update needed game properties
         game.updateCurrentItemIndex()
         
         
         //is it time to show the results
         if game.getPerson2().items.count < game.getHowManyCompatibilityItems() {
            self.currentPerson = game.getPerson2()
            updateUI(for: self.currentPerson!)
         } else {
            showResults()
            //restart()
         }
      }
   }
   
   
   //MARK: - UI Functions
   func restart() {
      guard let game = game else { print("no game instantiated"); return }
      
      game.reset() //reset values stored in the Game
   
      currentPerson = game.getPerson1()     //sets currentPerson to person1
      
      questionLabel.text = "User 1, what do you think about..." //default message
      compatibilityItemLabel.text = game.getCompatibilityItem()
      
      updateStarBorderWidth(for: leftStar)
      
      slider.value = 3.0 //default value
   }
   
   func updateUI(for person: Person) {
      var player: String
      
      guard let game = game else { print("no game instantiated to updateUI"); return }
      
      //person.id == 1 ? (player = "User 1, what do you think") : (player = "User 2, how do you feel")
      if person.id == 1 {
         player = "User 1, what do you think"
         updateStarBorderWidth(for: leftStar)
      } else {
         player = "User 2, how do you feel"
         updateStarBorderWidth(for: rightStar)
      }
      
      questionLabel.text = "\(player) about..."
      
      compatibilityItemLabel.text = game.getCompatibilityItem()
      
      slider.value = 3.0 //default value
      
   }
   
   func setUpUIElements() {
      nextButton.layer.borderWidth  = 2
      nextButton.layer.cornerRadius = 10
      nextButton.layer.borderColor  = UIColor.systemPurple.cgColor



      
      slider.thumbTintColor         = UIColor.systemPurple
      slider.minimumTrackTintColor  = UIColor.systemPurple
      slider.maximumTrackTintColor  = UIColor.systemPurple
      
      leftStar.layer.borderColor    = UIColor.systemPurple.cgColor
      rightStar.layer.borderColor   = UIColor.systemPurple.cgColor
   }
   
   func updateStarBorderWidth(for sender: UIImageView) {
      let opposite: UIImageView?

      sender == leftStar ? (opposite = rightStar) : (opposite = leftStar)
   
      sender.layer.borderWidth    = 2
      opposite!.layer.borderWidth = 0
   }
   
   
   //MARK: - Alert View
   func showResults () {
      let stringsTuple: (title: String, message: String, action: String) = getTitleAndMessage()

      let alert = UIAlertController(title: stringsTuple.title, message: stringsTuple.message, preferredStyle: .alert)
      let action = UIAlertAction(title: stringsTuple.action, style: .default, handler: { action in
         self.restart()
      })
      
      alert.addAction(action)
      
      present(alert, animated: true)
  }
   
   func getTitleAndMessage () -> (String, String, String)  {
      guard let game = game else { return ("Final Result", "your compatibility is not clear, please repeat the test", "Sure!") }
      
      var title: String?
      var message: String?
      var action: String?

      let compatDouble = Double(game.calculateCompatibility())
      let compatibility = Int(compatDouble!)
      
      switch  compatibility {
         //as min slider value is 1 (and not zero) the minimum value will be
         //20% and not 0%
      case 0...29:
         title = "Forever Alone."
         message = "You both were distracted when answering de questions. It is really hard to obtain a \(String(describing: compatibility)) % compatibility score... believe me, you must repeat the test..."
         action = "😓 mmm allright"
      case 30...49:
         title = "Opposites Attract."
         message = "Well, do not let your \(String(describing: compatibility)) % compatibility score  discourage you!."
         action = "😱 what the heck!?."
      case 50...69:
         title = "More than friends."
         message = "Your compatibility score of \(String(describing: compatibility)) % shows that there is something happening between you two."
         action = "😏 really?!."
      case 70...89:
         title = "Happy Forever."
         message = "Your compatibility score of \(String(describing: compatibility)) % predicts a really happy life together."
         action = "🤗 nice!"
      case 90...100:
         title = "Together Forever"
         message = "Congratulations!!, your score is \(String(describing: compatibility)) %. Nothing can stop you now!!."
         action = "🔥 happiness everywhere!."
      default:
         break
      }
      
      return (title!, message!, action!)
   }
}


