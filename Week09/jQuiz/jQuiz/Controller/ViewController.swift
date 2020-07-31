///
///  SoundManager.swift
///  jQuiz
///
///  Created by Jay Strawn,  Modified by Alberto Talaván
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!
  
  let networking = Networking.sharedInstance
  var categoryTitle: String?
  var clueAnswers: [String] = []
  var game = Game()


  override func viewDidLoad() {
    super.viewDidLoad()
    
    //initializeing UI
    restartUI()

    
    //tableView
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    
    //sound
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
      SoundManager.shared.playSound()
    }

  }
  
  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
      SoundManager.shared.stopSound()
      print("isSoundEnabled = false -> \(String(describing: SoundManager.shared.isSoundEnabled))")
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
      SoundManager.shared.playSound()
      print("isSoundEnabled = true -> \(String(describing: SoundManager.shared.isSoundEnabled))")
    }
  }
  
  //MARK: - getting Clues
  private func downloadClues(){
    getClues { downloadCompleted in
      if downloadCompleted {
        print("  CluesDownload completed")
        
        DispatchQueue.main.async {
          self.categoryTitle = self.game.getCategoryTitle() //clues Category
          self.clueAnswers = self.game.getClueList()    //clues to choose
          self.setUpUI()
        }
      }
    }
  }
  
  private func getClues(completion: @escaping (Bool) -> Void) {
    networking.getRandomCategory(completion: { category in
      guard let category = category else { return }
      self.game.setCategory(category)
      print("Category ID: \(String(describing: category.id))")
      print("Category cluesCount: \(String(describing: category.cluesCount))")
      
      self.networking.getAllCluesByCategory(categoryId: category.id ?? (Int.random(in: 1...15000)), completion: { clues in
        guard let clues = clues else {return}
        self.game.setInitialClueList(clues)
        completion(true)
      })
    })
    
  }
  
  //-------------------------------------------------------------------
  #warning("Jay I don´t know why this is not working the download and later change the image logo ... ")
  //because download is working
  
  func downloadImageLogo() {
    getImageLogo { downloadCompleted in
      if downloadCompleted {
        print("  ViewController -> imageLogo downloaded")
        
        DispatchQueue.main.async {
          self.logoImageView.image = self.game.getImageLogo()
        }
      }
    }
  }
  
  
  func getImageLogo(completion: @escaping (Bool) -> Void) {
    networking.downloadJeopardyLogo(completion: { image in
      guard let image = image else { return }
      self.game.setImageLogo(image)
    })
    
  }
  
  //-------------------------------------------------------------------
  
  
  //MARK: - new rounds and restarting game setting up
  private func setUpForNewRound() {
    //cleaning arrays
    clueAnswers.removeAll()
    tableView.reloadData()  //when restarting game this cleans the cells while downloading new clues
    
    game.newRound()
    
    downloadClues()
  }
  
  private func restartUI() {
    initialUISetUp()
    setUpForNewRound()
  }
  
  
  
  //MARK: - setting up the User Interface
  private func setUpUI() {
    categoryLabel.text = categoryTitle
    clueLabel.text = game.getWinnerQuestion()!
    tableView.reloadData()
    
    scoreLabel.text = "\(String(self.game.getScore()))"
  }
  
  private func initialUISetUp() {
    logoImageView.image = UIImage(named:"JeopardyLogoB&W")
    
    //getting image logo from internet
    downloadImageLogo()
    
    categoryLabel.text = ""
    clueLabel.text = ""
    scoreLabel.text = ""
  }
  
  
  
  //MARK: - values for alert view
  private func valuesForAlertView(isItRight right: Bool) -> (String, String) {
    let title: String
    let message: String
    
    switch right {
    case true:
      title = "Right Answer"
      message = "You did it!"
    case false:
      title = "Wrong Answer"
      message = "No worries, next time you will get the right one!"
    }
    
    return (title, message)
  }

}



//MARK: - Extension ViewController
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return clueAnswers.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.backgroundColor = .systemPurple
    cell.textLabel?.text = clueAnswers[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let isRightAnswer = game.checkAnswer(for: indexPath.row)
    
    let stringTuple: (title: String, message: String) = valuesForAlertView(isItRight: isRightAnswer)
    
    let ac = UIAlertController(title: stringTuple.title, message: stringTuple.message, preferredStyle: .alert)
    let newRound = UIAlertAction(title: "Next Question PLZ", style: .default) { action in
      self.setUpForNewRound()
    }
    let restartGame = UIAlertAction(title: "Restart Game", style: .destructive) {action in
      self.game.start()
      self.restartUI()
      
    }
    
    ac.addAction(newRound)
    ac.addAction(restartGame)
    present(ac,animated: true)
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

