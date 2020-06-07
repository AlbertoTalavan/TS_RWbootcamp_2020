//
//  ViewController.swift
//  BullsEye
//
//  Created by Alberto Talaván on 27/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class Controller: UIViewController {

   let game = BullsEyeGame()
   
   
   @IBOutlet weak var slider:      UISlider!
   @IBOutlet weak var randomLabel: UILabel!
   @IBOutlet weak var scoreLabel:  UILabel!
   @IBOutlet weak var roundLabel:  UILabel!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stylingSlider()
      game.setCurrentValue(to: Int(slider.value.rounded()))
      
      scoreLabel.text = String(game.getScore())
      roundLabel.text = String(game.getRound())
      startOver()

   }
   
   //MARK: - Actions
   @IBAction func startOver() {
      reset()
      updateViews()
   }

   @IBAction func showAlert() {
 /*
      //computed property inside the Model)
      // - Calculate difference (currentValue - targetValue)
      // - Difference in absolute value => abs(difference)

      
      //assign points addPoints(100 - difference) (in alertTitleComponents)
      //game.addPoints(add: 100 - game.getDifference())
 */
      //obtain show alert parameters and store them in tuple
      let tuple: (title: String, message: String) = alertViewComponents()
       
/*
      //updating the amount of points achieved if necessary
      //in alertTitleComponents
      //game.addPoints(add: tuple.points)


      //Alert message (hardcoded here) in alertTitleComponents
      //let message = "You scored: \(game.getPoints())"
 */
      
      let alert = UIAlertController(
         title: tuple.title,
         message: tuple.message,
         preferredStyle: .alert)
      
      let action = UIAlertAction(title: "awesome", style: .default) { (action) in
         self.game.addScore(add: self.game.getPoints())
         self.startNewRound()
         self.updateViews()
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
      
   }

   @IBAction func sliderMoved(_ slider: UISlider) {
      let roundedValue = slider.value.rounded()
      game.setCurrentValue(to: Int(roundedValue))
      
   }
   
   
   //MARK: - Game Core Functionality
   func alertViewComponents() -> (String, String) {
      var title: String
      var extraPoints: Int = 0
      let message: String
      
      let difference = game.getDifference()
      
      if difference == 0 {
         title = "Perfect!"
         extraPoints += 100
      }else if difference == 1 {
         title = "You almost had it!"
         extraPoints += 50
      }else if difference < 5 {
         title = "You almost had it!"
      } else if difference < 10 {
         title = "Pretty good!"
      } else {
         title = "meh!, not even close!"
      }
      
      //adding total points after getting extraPoints
      game.addPoints(add: 100 - game.getDifference() + extraPoints)
      
      message = "You scored: \(game.getPoints())"
      
      
      return (title, message)
   }
   
   
   //MARK: - Start new round And Reset
   func startNewRound() {
   game.setPoints(to: 0)
   game.nextRound()
   game.setTargetValue(to: Int.random(in: 1...100))

   }
     
   func reset() {
   game.setRound(to: 1)
   game.setScore(to: 0)
   game.setPoints(to: 0)
      
   game.setTargetValue( to: Int.random(in: 1...100))

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
      game.setCurrentValue(to: 50)
      slider.value = Float(game.getCurrentValue())
      
      randomLabel.text = String(game.getTargetValue())
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

