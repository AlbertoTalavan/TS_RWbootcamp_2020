//
//  ViewController.swift
//  BullsEye
//
//  Created by Alberto Talaván on 27/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   var currentValue = 0
   var targetValue  = 0
   var score        = 0
   var round        = 0
   
   @IBOutlet weak var slider:      UISlider!
   @IBOutlet weak var randomLabel: UILabel!
   @IBOutlet weak var scoreLabel:  UILabel!
   @IBOutlet weak var roundLabel:  UILabel!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      stylingSlider()
      currentValue = Int(slider.value.rounded())
      scoreLabel.text = String(0)
      roundLabel.text = String(0)
      startOver()

   }
   
   @IBAction func startOver() {
      round = 0
      score = 0
      startNewRound()
   }
   
   
   @IBAction func showAlert() {
      let difference = abs(currentValue - targetValue)
      var points = 100 - difference
      let title: String

      if difference == 0 {
         title = "Perfect!"
         points += 100
      }else if difference == 1 {
         title = "You almost had it!"
         points += 50
      }else if difference < 5 {
         title = "You almost had it!"
      } else if difference < 10 {
         title = "Pretty good!"
      } else {
         title = "meh, not even close!"
      }
      
      let message = "You scored: \(points)"
      
      score += points
      
      
      let alert = UIAlertController(
                  title: title,
                  message: message,
                  preferredStyle: .alert)
      
      let action = UIAlertAction(title: "awesome", style: .default) { (action) in
         self.startNewRound()
      }
      
      alert.addAction(action)
      
      present(alert, animated: true, completion: nil)
      
   }
   
   @IBAction func sliderMoved(_ slider: UISlider) {
      let roundedValue = slider.value.rounded()
      currentValue = Int(roundedValue)
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
   
   func startNewRound() {
      round += 1
      targetValue = Int.random(in: 1...100)
      
      currentValue = 50
      slider.value = Float(currentValue)
      
      updateLabels()
   }
   
   func updateLabels() {
      randomLabel.text = String(targetValue)
      scoreLabel.text  = String(score)
      roundLabel.text  = String(round)
      
   }
   

}

