///
///  NetworkingHandler.swift
///  jQuiz
///
///  Created by Alberto Talaván on 26/07/2020.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import UIKit

class Networking {
  
  static let sharedInstance = Networking()

  private let session = URLSession(configuration: URLSessionConfiguration.default)
  private var url: URL?
  private let baseURL = "http://www.jservice.io"
  private let randomClueURLExtension = "/api/random" //same response as "/api/random/?count=1"
  private let cluesForCategoryURLExtension = "/api/clues/?category="
  private let imageUrlString = "https://vignette.wikia.nocookie.net/jeopardyhistory/images/7/7a/Jeopardy_Season_36_%282019-2020%29_title_card.jpg"
  //Original link "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c 826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg​" //not working at this moment
  private var category: Category?
  private var clues = [Clue]()
  private var imageLogo: UIImage?
  
  private init() {
    self.url = URL(string: baseURL)
  }

  //MARK: - decoding data from json file
  private func decodeData(type: taskType, data: Data) -> AnyObject {
    var category: Category?
    var listOfClues = [Clue]()
    switch type {
    case .category:
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let clue = try decoder.decode([Clue].self, from: data)
        category = clue[0].category
      } catch {
        print("Error decoding json data: \(error)")
      }
      return category as AnyObject
      
    case .clues:
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let clues = try decoder.decode([Clue].self, from: data)
        listOfClues = clues
      } catch {
        print("Error decoding json data: \(error)")
      }
      
    case .image:
      let image = UIImage(data: data)
    }
    return listOfClues as AnyObject
  }
  
  //MARK: - getters
  func getRandomCategory(completion: @escaping (Category?) -> Void) {
    let urlString = baseURL + randomClueURLExtension
    
    guard let url = URL(string: urlString) else { return }
    
    let task = self.session.dataTask(with: url) { data, response, error in
      
      if let _ = error { print("Some error happened, please verify your connection and try again later")}
      
      guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
        print ("Invalid response from the server, please try again later")
        return
      }
      
      guard let data = data else {
        print("Invalid data received from the server")
        return
      }
      
      self.category = (self.decodeData(type: .category, data: data) as! Category)
      completion(self.category)
    }
    task.resume()
  }
  

  func getAllCluesByCategory(categoryId: Int, completion: @escaping ([Clue]?) -> Void) {
    let urlString = baseURL + cluesForCategoryURLExtension + String(categoryId)
    
    guard let url = URL(string: urlString) else { return }
    
    let task = self.session.dataTask(with: url) { data, response, error in
      
      if let _ = error { print("Some error happened, please verify your connection and try again later")}
      
      guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
        print ("Invalid response from the server, please try again later")
        return
      }
      
      guard let data = data else {
        print("Invalid data received from the server")
        return
      }
      
      self.clues = (self.decodeData(type: .clues, data: data) as? [Clue])!
      completion(self.clues)
    }
    task.resume()
    
  }
  
  
  func downloadJeopardyLogo(completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: imageUrlString) else { return }
    
    let task = self.session.dataTask(with: url) { data, response, error in
      
      if let _ = error { print("LogoImage -> Some error happened, please verify your connection and try again later")}
       
      guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
        print ("  LogoImage -> Invalid response from the server, please try again later")
        return
      }
      
      print("## -- LogoImage -> response: \(response.statusCode)")
      
      guard let data = data  else {
          print("LogoImage -> Invalid data received from the server")
          return
      }
      
      self.imageLogo = (self.decodeData(type: .image, data: data) as? UIImage)
        print("## -- Networking -> imageLogo download and creation: completed")
      completion(self.imageLogo)
    }
    task.resume()
  }
  
}


extension Networking {
  enum taskType {
    case category, clues, image
  }
}



