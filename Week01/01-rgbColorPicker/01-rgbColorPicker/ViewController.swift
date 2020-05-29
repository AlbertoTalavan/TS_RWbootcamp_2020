//
//  ViewController.swift
//  01-rgbColorPicker
//
//  Created by Alberto Talaván on 29/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var colorNameLabel:        UILabel!
   @IBOutlet weak var segmentedControlLabel: UILabel!
   @IBOutlet weak var redHueLabel:           UILabel!
   @IBOutlet weak var greenSaturationLabel:  UILabel!
   @IBOutlet weak var blueBrightnessLabel:   UILabel!
   
   @IBOutlet weak var rhValueLabel: UILabel!
   @IBOutlet weak var gsValueLabel: UILabel!
   @IBOutlet weak var bbValueLabel: UILabel!
   
   @IBOutlet weak var rhSlider: UISlider!
   @IBOutlet weak var gsSlider: UISlider!
   @IBOutlet weak var bbSlider: UISlider!
   
   
   var rh = 0
   var gs = 0
   var bb = 0
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
   
   //MARK: - Segmented Control
   @IBAction func modeChanged(_ sender: Any) {
      
   }
   
   
   //MARK: - Sliders
   @IBAction func rhSliderMoved(_ sender: Any) {
      
   }
   
   @IBAction func gsSliderMoved(_ sender: Any) {
      
   }
   
   @IBAction func bbSliderMoved(_ sender: Any) {
      
   }
   
   
   //MARK: - Buttons
   @IBAction func setColor(_ sender: UIButton) {
      
   }
   
   @IBAction func reset(_ sender: UIButton) {
      
   }
   
   
}

