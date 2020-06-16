//
//  ViewController.swift
//  Cryptly
//
//  Created by Alberto Talaván on 13/06/2020.
//  Copyright © 2020 Alberto Talaván. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController{

  //@IBOutlet var widgetViews: [WidgetView]!
  //@IBOutlet var widgetLabels: [UILabel]!
  
  @IBOutlet weak var view1: WidgetView!
  @IBOutlet weak var view2: WidgetView!
  @IBOutlet weak var view3: WidgetView!
  
  @IBOutlet weak var fallingView: WidgetView!
  @IBOutlet weak var risingView:  WidgetView!
  
  @IBOutlet weak var headingLabel: UILabel!
  
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  
  @IBOutlet weak var mostFallingLabel:  UILabel!
  @IBOutlet weak var fallingValueLabel: UILabel!
  @IBOutlet weak var mostRisingLabel:   UILabel!
  @IBOutlet weak var risingValueLabel:  UILabel!

  @IBOutlet weak var themeSwitch: UISwitch!

  let cryptoData = DataGenerator.shared.generateData()

  let valueRise: Float = 0 // positive/negative value means: rising/falling trend
  
    
//------------------//------------------
  var widgetViews: [WidgetView] = []
  var widgetLabels: [UILabel] = []
//------------------//------------------
  
  
  //MARK: - ViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
//------------------//------------------//------------------
    widgetViews = [view1, view2, view3, fallingView, risingView]
    widgetLabels = [view1TextLabel, view2TextLabel, view3TextLabel, mostFallingLabel, mostRisingLabel]
//------------------//------------------//------------------

    ThemeManager.shared.set(theme: themeSwitch.isOn ? DarkTheme() : LightTheme())

    settingUI(theme: ThemeManager.shared.currentTheme! )

    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setFallinViewData()
    setRisingViewData()
    
    
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
  func applyRoundToWidgetView(whichOne myView: WidgetView){
 
    //applying round() with different cornerRadius values
    switch myView {
    case view1: myView.setCornerRadius(to: 30)
    case view2, view3: myView.setCornerRadius(to: 10 )
    case fallingView, risingView:
      myView.setCornerRadius(to: 35)
      //myView.clipsToBounds = true
    default:
      break
    }
    myView.round()
    
  }
  
  func setupLabels() {
    headingLabel.font      = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font    = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font    = UIFont.systemFont(ofSize: 18, weight: .regular)
    fallingValueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    risingValueLabel.font  = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setView1Data() {
    guard let cryptoData = cryptoData else { return }
    let currencies = cryptoData.map { $0.name }
 
    view1TextLabel.text = currencies.joined(separator: ", ")

  }
  
  func setView2Data() {
    guard let cryptoData = cryptoData else { return }
    let currencies = cryptoData.filter { $0.trend == .rising }.map { $0.name }

    view2TextLabel.text = currencies.joined(separator: ", ")
  }
  
  func setView3Data() {
    guard let cryptoData = cryptoData else { return }
    let currencies = cryptoData.filter { $0.trend == .falling }.map { $0.name }
     
    view3TextLabel.text = currencies.joined(separator: ", ")
  }
  
  func setFallinViewData(){
    guard let cryptoData = cryptoData else { return }
    let currency = cryptoData.min { $0.difference <= $1.difference }
    
    if let currency = currency {
      fallingValueLabel.text = "\(currency.name): \(currency.difference)"
    }else {
      fallingValueLabel.text = "no currency data "
    }
  }
  
  func setRisingViewData(){
    guard let cryptoData = cryptoData else { return }
    let currency = cryptoData.min { $0.difference >= $1.difference }
    
    if let currency = currency {
      risingValueLabel.text = "\(currency.name): \(currency.difference)"
    }else {
      risingValueLabel.text = "no currency data "
    }
  }
  
  
  //MARK: - Actions
  @IBAction func switchPressed(_ sender: Any) {
    //themeSwitch.isOn ? ThemeManager.shared.set(theme: DarkTheme()) : ThemeManager.shared.set(theme: LightTheme())
    ThemeManager.shared.set(theme: themeSwitch.isOn ? DarkTheme() : LightTheme())
  }
  
  //MARK: - UI set up due to switch
  func settingUI(theme: Theme) {
    //main View
    view.backgroundColor     = theme.backgroundColor
    
    //WidgetViews
      //no changing components
      widgetViews.forEach { $0.setView()}
      
      //changing components
      widgetViews.forEach {
        $0.backgroundColor = theme.widgetBackgroundColor
        $0.layer.borderColor = theme.borderColor.cgColor
      }
    
    
    //heading label
    headingLabel.textColor   = theme.textColor
    
    //WidgetLabels 1 - 3 colours
    widgetLabels.forEach {$0.textColor = theme.textColor }
    
    //special labels colours
      //falling value colour = red
      fallingValueLabel.textColor = theme.fallingColor
      
      //rising value colour = green
      risingValueLabel.textColor = theme.risingColor
    

    //Rounding widgetViews
    applyRoundToWidgetView(whichOne: view1)
    applyRoundToWidgetView(whichOne: view2)
    applyRoundToWidgetView(whichOne: view3)
    applyRoundToWidgetView(whichOne: fallingView)
    applyRoundToWidgetView(whichOne: risingView)


  }
  
}

//MARK: - Extensions
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
    settingUI(theme: ThemeManager.shared.currentTheme!)
  }
  
}





