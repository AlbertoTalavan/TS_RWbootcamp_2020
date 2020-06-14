//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//
import UIKit


extension HomeViewController: Themable {
  func registerForTheme() {
    // should use NotificationCenter to add the current object as an observer for when the “themeChanged” notification occurs.
    NotificationCenter.default.addObserver(self, selector: #selector (themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    //should remove the current object as an observer.
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    if themeSwitch.isOn { settingUI(theme: DarkTheme()) }
    else { settingUI(theme: LightTheme()) }
  }
  
}


class HomeViewController: UIViewController{

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  
  @IBOutlet weak var fallingView: UIView!
  @IBOutlet weak var risingView: UIView!
  
  @IBOutlet weak var headingLabel: UILabel!
  
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  
  @IBOutlet weak var mostFallingLabel: UILabel!
  @IBOutlet weak var fallingValueLabel: UILabel!
  @IBOutlet weak var mostRisingLabel: UILabel!
  @IBOutlet weak var risingValueLabel: UILabel!

  @IBOutlet weak var themeSwitch: UISwitch!

  let cryptoData = DataGenerator.shared.generateData()
  
  enum Trend {
    case rising
    case falling
  }
  
  let valueRise: Float = 0
    
  
  //MARK: - ViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    themeSwitch.isOn ? settingUI(theme: DarkTheme()) : settingUI(theme: LightTheme())

    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  

  //MARK: - Setting Up Views
  func setUpViewComponents(whichOne myView: UIView, _ theme: Theme){
    //no changing components
    myView.layer.borderWidth = 1.0
    myView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    myView.layer.shadowOffset = CGSize(width: 0, height: 2)
    myView.layer.shadowRadius = 4
    myView.layer.shadowOpacity = 0.8
    
    //changing components
    myView.backgroundColor    = theme.widgetBackgroundColor
    myView.layer.borderColor  = theme.borderColor.cgColor
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    fallingValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    risingValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setView1Data() {
    let currenciesName = cryptoData?.map { $0.name }
    
    guard let currencies = currenciesName else { return }
    view1TextLabel.text = currencies.joined(separator: ", ")

  }
  
  func setView2Data() {
    let currenciesName = cryptoData.map { $0 }?.filter { $0.currentValue > $0.previousValue}.map { $0.name }

    guard let currencies = currenciesName else { return }
    view2TextLabel.text = currencies.joined(separator: ", ")
  }
  
  func setView3Data() {
    // cryptoData has the data
    let currenciesName = cryptoData.map { $0 }?.filter { $0.currentValue < $0.previousValue}.map { $0.name }
     
    guard let currencies = currenciesName else { return }
    view3TextLabel.text = currencies.joined(separator: ", ")
  }
  
  
  //MARK: - Actions
  @IBAction func switchPressed(_ sender: Any) {
    themeChanged()
  }
  
  //MARK: - UI set up due to switch
  func checkDeviceTheme() {
    if traitCollection.userInterfaceStyle == .light {
      themeSwitch.isOn = false
    } else { //userInterfaceStyle == .dark or Any
      themeSwitch.isOn = true
    }
  }
  
  func settingUI(theme: Theme) {
    //main View
    view.backgroundColor     = theme.backgroundColor
    
    //heading label
    headingLabel.textColor   = theme.textColor
    
    //view1
    setUpViewComponents(whichOne: view1, theme)
    view1TextLabel.textColor = theme.textColor
    
    //view2
    setUpViewComponents(whichOne: view2, theme)
    view2TextLabel.textColor = theme.textColor
    
    //view3
    setUpViewComponents(whichOne: view3, theme)
    view3TextLabel.textColor = theme.textColor
    
    //fallingView
    setUpViewComponents(whichOne: fallingView, theme)
    fallingValueLabel.textColor = theme.fallingColor
    
    //risingView
    setUpViewComponents(whichOne: risingView, theme)
    risingValueLabel.textColor = theme.risingColor
  }
  
}




