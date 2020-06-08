//
//  ViewController.swift
//  BullsEye
//
//  Created by Alberto Talaván on 27/05/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//

import UIKit

class Controller: UIViewController {

   let game = BullsEyeGame()
   
   @IBOutlet weak var gessTextField: UITextField!
   
   @IBOutlet weak var slider:      UISlider!
   @IBOutlet weak var scoreLabel:  UILabel!
   @IBOutlet weak var roundLabel:  UILabel!
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //self.hideKeyboard() // used to dismiss the keyboard if pressed outside it
      
      stylingSlider()
      game.setCurrentValue(to: Int(slider.value.rounded()))

      startOver()

   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
      
      view.endEditing(true)
   }
   
   
   
   //MARK: - Actions
   @IBAction func startOver() {
      reset()
      updateViews()
   }

   @IBAction func showAlert() {
      #warning("To REVISE")
      let tuple: (title: String, message: String, buttonMessage: String) = alertViewStringComponents()

      let alert = UIAlertController(
         title: tuple.title,
         message: tuple.message,
         preferredStyle: .alert)
      
      let action = UIAlertAction(title: tuple.buttonMessage, style: .default) { (action) in
         self.addScore(add: self.game.getPoints())
         self.startNewRound()
         self.updateViews()
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
      
   }

   @IBAction func sliderMoved(_ slider: UISlider) {
      #warning("To REVISE") // This one now it is not useful, we´ll place the slider to it´s random position
      let roundedValue = slider.value.rounded()
      game.setCurrentValue(to: Int(roundedValue))
      
   }
   
   
   //MARK: - Game Core Functionality
   #warning("To REVISE")
   func alertViewStringComponents() -> (String, String, String) {
      let title: String
      let message: String
      let hitMeText: String
      var extraPoints: Int = 0
      
      let difference = game.getDifference()
      
      if difference == 0 {
         title = "Perfect!"
         extraPoints += 100
         hitMeText = "I´m the best"
      }else if difference == 1 {
         title = "You almost had it!"
         extraPoints += 50
         hitMeText = "I rock!"
      }else if difference < 5 {
         title = "You almost had it!"
         hitMeText = "pretty awesome"
      } else if difference < 10 {
         title = "Pretty good!"
         hitMeText = "awesome"
      } else {
         title = "meh!, not even close!"
         hitMeText = "mmm allright"
      }
      
      //adding total points after getting extraPoints
      addPoints(add: 100 - game.getDifference() + extraPoints)
      
      message = "You scored: \(game.getPoints())"
      
      
      return (title, message, hitMeText)
   }
   
   //MARK: - Score and Points (adding a value)
   func addScore(add value: Int) {
      let score = game.getScore()
      game.setScore(to: score + value)  //updating the score
   }
   
   func addPoints(add value: Int) {
      let points = game.getPoints()
      game.setPoints(to: points + value)
   }
   
   
   //MARK: - Start new round And Reset
   func startNewRound() {
      nextRound()
      game.setPoints(to: 0)
      game.setTargetValue(to: Int.random(in: 1...100))
   }
     
   func reset() {
      game.setRound(to: 1)
      game.setScore(to: 0)
      game.setPoints(to: 0)
      game.setTargetValue( to: Int.random(in: 1...100))
   }
   
   func nextRound() {
      let round = game.getRound()
      game.setRound(to: round + 1)
   }
   
   
   //MARK: - Styling updating views
   func stylingSlider() {
      //let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
      let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
      slider.setThumbImage(thumbImageNormal, for: .normal)
      
      let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
      slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
      
      let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
      
      let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
      let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
      
      let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
      let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
      slider.setMaximumTrackImage(trackRightResizable, for: .normal)
   }
   
   func updateViews() {
      #warning("To REVISE")
      game.setCurrentValue(to: 50)
      slider.value = Float(game.getCurrentValue())
      
      //randomLabel.text = String(game.getTargetValue())  Does not exists anymore
      scoreLabel.text  = String(game.getScore())
      roundLabel.text  = String(game.getRound())
      
      //crossfade transition
      let transition = CATransition()
      transition.type = CATransitionType.fade
      transition.duration = 1
      transition.timingFunction = CAMediaTimingFunction(name:
                                  CAMediaTimingFunctionName.easeOut)
      view.layer.add(transition, forKey: nil)
      
   }

}

