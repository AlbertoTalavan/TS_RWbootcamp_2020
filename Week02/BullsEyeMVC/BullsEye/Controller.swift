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
      game.setCurrentValue(Int(slider.value.rounded()))
      
      scoreLabel.text = String(game.getScore())
      roundLabel.text = String(game.getRound())
      startOver()

   }
   
   @IBAction func startOver (){
      game.reset()
      updateViews()
   }
   
   
   @IBAction func showAlert() {
      //Calculate difference
      game.calculateDifference(this: game.getCurrentValue(), minus: game.getTargetValue())
      
      //Difference in absolute value
      game.setDifference(abs(game.getDifference()))
      
      
      //assign points
      game.addPoints(100 - game.getDifference())
      
      //obtain show alert parameters and store them in tuple
      let tuple: (title: String, points: Int) = game.gameNucleus()
      
      //alert title
      let title = tuple.title
      
      //updating the amount of points achieved if necessary
      game.addPoints(tuple.points)


      //Alert message (hardcoded here)
      let message = "You scored: \(game.getPoints())"
      
      
      
      
      let alert = UIAlertController(
                  title: title,
                  message: message,
                  preferredStyle: .alert)
      
      let action = UIAlertAction(title: "awesome", style: .default) { (action) in
         self.game.updateScore(add: self.game.getPoints())
         self.game.startNewRound()
         self.updateViews()
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
      
   }
   
   
   
   @IBAction func sliderMoved(_ slider: UISlider) {
      let roundedValue = slider.value.rounded()
      game.setCurrentValue(Int(roundedValue))
      
   }
   
   
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
      game.setCurrentValue(50)
      slider.value = Float(game.getCurrentValue())
      
      randomLabel.text = String(game.getTargetValue())
      scoreLabel.text  = String(game.getScore())
      roundLabel.text  = String(game.getRound())
      
   }
   

}

