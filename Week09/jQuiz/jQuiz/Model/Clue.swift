///
///  Clue.swift
///  jQuiz
///
///  Created by Alberto Talaván on 26/07/2020.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///



struct Clue: Codable {
  let id: Int?
  let question: String?
  let answer: String?
  let value: Int?
  let category: Category
}

struct Category: Codable {
  let id: Int
  let title: String
  let cluesCount: Int

}
