///
///  SoundManager.swift
///  jQuiz
///
///  Created by Jay Strawn on 7/17/20.
///  Copyright © 2020 Jay Strawn. All rights reserved.
///

//import Foundation
import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()

    private var player: AVAudioPlayer?

    var isSoundEnabled: Bool? {
        get {
            // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
            // You might want to use `object`, because if an object has not been set yet it will be nil
            // Then if it's nil you know it's the user's first time launching the app
//            UserDefaults.standard.object(forKey: "sound") as? Bool
          UserDefaults.standard.bool(forKey: "sound")
        }
    }
  
  override init() {
    guard let filePath = Bundle.main.path(forResource: "Jeopardy-theme-song", ofType: "mp3") else {
      print("Jeopardy-theme-song audio file not found")
      return
    }
    do {
       try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath)  )
    } catch {
      print("Some error occurred with the jeopardy-theme-song file: \(error)")
    }
  }
  

    func playSound() {
      player?.play()
    }
  
  func stopSound() {
    player?.stop()
  }

    func toggleSoundPreference() {
      UserDefaults.standard.bool (forKey: "sound") == false ?
        UserDefaults.standard.set(true, forKey: "sound")  :
        UserDefaults.standard.set(false, forKey: "sound")
    }

}

