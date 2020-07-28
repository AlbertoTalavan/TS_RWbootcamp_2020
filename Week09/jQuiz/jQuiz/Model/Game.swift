///
///  Game.swift
///  jQuiz
///
///  Created by Alberto Talaván on 26/07/2020.
///  Copyright © 2020 Alberto Talaván. All rights reserved.
///

import Foundation

final class Game {
  private var category: Category?
  private var initialClueList: [Clue] = []
  private var clues = [Clue]()
  private var winnerIndex: Int?
  private var score: Int = 0

  
  //MARK: - Game methods
  func start() {
    score = 0
    newRound()
  }
  
  func newRound() {
    initialClueList.removeAll()
    clues.removeAll()
  }
  
  func addPoints(add points: Int) {
    score += points
  }
  
  func checkAnswer(for indexPath: Int) -> (Bool) {
    let randomPoints = Int.random(in: 100...1000) //for questions whose value (points) = nil
    if indexPath == winnerIndex {
      addPoints(add: clues[winnerIndex!].points ?? randomPoints)
      return true
    } else {
      return false
    }
  }
  
  private func getWinnerIndex() -> Int {
    Int.random(in: 0..<clues.count)
  }
  
  func getWinnerQuestion() -> String? {
    winnerIndex = getWinnerIndex()
    let winnerClue = clues[winnerIndex!]
    print("Winner Question: \(String(describing: winnerClue.question))")
    print("Winner Answer: \(String(describing: winnerClue.answer))")
    print("winner points: \(String(describing: winnerClue.points))")
    return winnerClue.question
  }

  
  //MARK: - getters
  func getClueList() -> [String] {
    //improvement -> do all this process in the networking call or in the viewController getClues()
    
// TODO: Can be questions/answers repeated inside the same Category and with different Clue.id
    //example: category = 16744
    // clue positions: 9 and 6, 8 and 3, 2 and 7, 1 and 5, 0 and 4 are the same
    
    //final version
    var cluesString = [String]()
    let max = initialClueList.count
    var hardcodedIndex = 0
    var indexUsed = [Int]()
    for _ in 0..<4 {
      let index = Int.random(in: 4..<max) //because hardcodedIndex could take values from 0 to 3 and we do not like repeated values
      if indexUsed.contains(index) {
        clues.append(initialClueList[hardcodedIndex])
        indexUsed.append(hardcodedIndex)
        hardcodedIndex += 1
      }else {
        if initialClueList[index].question == "" {
          clues.append(initialClueList[hardcodedIndex])
          indexUsed.append(hardcodedIndex)
          indexUsed.append(index)
          hardcodedIndex += 1
        } else {
          clues.append(initialClueList[index])
          indexUsed.append(index)
        }
      }
    }
        print("Clues selected: \(indexUsed)")
    cluesString = clues.map {$0.answer!}
    
    return cluesString
  }
  
  func getCategoryTitle() -> String {
    return category!.title ?? "No categorized question"
  }

  func getScore() -> Int {
    return score
  }
  
  
  //MARK: - setters
  func setInitialClueList(_ clues: [Clue]) {
    initialClueList = clues
  }
  
  func setCategory(_ category: Category) {
    self.category = category
  }
  
}

