///
///  Clue.swift
///  jQuiz
///
///  Created by Alberto Talaván on 26/07/2020.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import Foundation

struct Clue: Codable {
  let id: Int?
  let question: String?
  let answer: String?
  let points: Int?
  let category: Category
  
  enum CodingKeys: String, CodingKey {
    case id
    case question
    case answer
    case points = "value"
    case category
  }
}

struct Category: Codable {
  let id: Int?
  let title: String?
  let cluesCount: Int?  // for this one I am not using "CodingKeys" to change from "clues_count".
                       // I will use "decoder.keyDecodingStrategy = .convertFromSnakeCase" instead.
                       

}
