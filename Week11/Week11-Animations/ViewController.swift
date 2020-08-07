//
//  ViewController.swift
//  Week11-Animations
//
//  Created by Alberto Talaván on 07/08/2020.
//  Copyright © 2020 Alberto Talavan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var squareColourButton: UIButton!
  @IBOutlet weak var squareSizeButton: UIButton!
  @IBOutlet weak var squareTranslationButton: UIButton!
  
  private var menuIsOpen = false
  @IBOutlet private var colorLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var translationTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var sizeBottomConstraint: NSLayoutConstraint!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setButtons()
  }

  @IBAction func toggleMenu(_ sender: UIButton) {
    menuIsOpen.toggle()
    colorLeadingConstraint.constant = menuIsOpen ? 68 : 162.5
    
    translationTrailingConstraint.constant = menuIsOpen ? 68 : 162.5
    
    sizeBottomConstraint.constant = menuIsOpen ? 44 : -50
    
  }
  

}

private extension ViewController {
  func setButtons() {
    let buttons: [UIButton]
    buttons = [playButton, squareColourButton, squareSizeButton, squareTranslationButton]
    
    buttons.forEach {
      $0.layer.cornerRadius = $0.frame.width / 2
      $0.tintColor = UIColor.white
    }
    buttons[0].backgroundColor = .systemOrange
    buttons[1].backgroundColor = .systemRed
    buttons[2].backgroundColor = .systemPurple
    buttons[3].backgroundColor = .systemTeal
  }
  
  
}

