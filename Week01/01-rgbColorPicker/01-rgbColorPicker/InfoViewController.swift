//
//  InfoViewController.swift
//  01-rgbColorPicker
//
//  Created by Alberto Talaván on 31/05/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {
   
   var colorType: String?
   
   var color: UIColor?
   

   
   @IBOutlet weak var webView: WKWebView!
   
   @IBOutlet weak var closeButton: UIButton!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      configureButton()
      simpleNetworkRequest()
      
   }
   
   @IBAction func close (_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   func simpleNetworkRequest(){
      //https://en.wikipedia.org/wiki/RGB_color_model
      //https://en.wikipedia.org/wiki/HSL_and_HSV
      var urlString: String = ""
      let request: URLRequest
      if let colorType = colorType {
         if colorType == "rgb" {
            urlString = "https://en.wikipedia.org/wiki/RGB_color_model"
         }else if colorType == "hsb" {
            urlString = "https://en.wikipedia.org/wiki/HSL_and_HSV"
         }
         
      } else {
       urlString = "https://en.wikipedia.org/wiki/RGB_color_model"
      }
         
      request = URLRequest(url: URL(string: urlString)!)
      
      webView.load(request)
      
   }
   
   
   @IBAction func closeButtonPressed(_ sender: UIButton) {
      dismiss(animated: true)
   }
   
   
   func configureButton(){
      closeButton.layer.cornerRadius = 5
      closeButton.layer.borderWidth  = 1
      
      closeButton.backgroundColor = color

   }

   
}
