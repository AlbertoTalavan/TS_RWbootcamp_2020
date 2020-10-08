# Week 09.
### Jquiz.
JQuiz is an app featuring Jeopardy-like quiz that **fetches data from the [JService.io API](http://www.jservice.io)**, which stores more that 150.000 trivia questions, and **presents to the user a question with four possible options** to choose from.  
The network call returns only 4 clues. The question for the category is closen randomly from the array of those 4 returned clues.  
The app also allows to **play/pause background music** during the game and the actual user selection setting is persisted between relaunches.

<p align="center"> <!-- using the assets directory -->
	<img src="/Week09/Assets/pic01.png" height="500"/> 
	<img src="/Week09/Assets/pic02.png" height="500"/>
</p>   

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
![iOS](https://img.shields.io/badge/iOS-13.2+-lightgrey.svg?longCache=true&?style=plastic&logo=apple)

## Tech Stack.
- Storyboards
- Autolayout
- UIKit
- URLSession


