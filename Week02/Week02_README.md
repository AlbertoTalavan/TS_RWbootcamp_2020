# WEEK 2  (Monday 1st June to Sunday 7th June)

This week assignments :
- **Bull´s Eye MVC:** this one is mandatory, 
- **RGB Bull´s Eye:** also mandatory,  
- **Reversed Bulls Eye:** I know, you are thinking of mandatoriness of this one too...  
                       but....NOPE!!, this is the optional one ...SURPRISE!!!! 
                       Pretty sure you didn´t expect it huh?.
---

## Bull´s Eye MVC

| ![gif light](/Week02/Assets-Gifs/BullsEyeMVC.png) | ![gif light](/Week02/Assets-Gifs/BullsEyeMVC.gif) |
| ------------------------------------------------- | ------------------------------------------------- |


[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0+-lightgrey.svg?longCache=true&?style=plastic&logo=apple)](https://developer.apple.com/ios/)


I have used a class (instead of a struct) because of the following reasons:
- **I want to define the game as a constant:** during the game ALL the properties of the model will change... with a struct It is necessary to declare it (the game) as a variable -> even if I use  let properties in the struct and also  mutating functions to be able to change the value of those properties... I will need to declare the struct as a variable  
- **I want to keep `private` the game properties:** In order to avoid freely access to its properties, and with the thought of dodging some errors if we operate them directly. In order to read/write this properties  it will be mandatory to do it through the **methods** available for that purpose  (getters/setters). There is also a computed property that only needs to be read (through a getter) due to we do not need to write it from outside the model.  

That said, **and because I do NOT NEED to use _INHERITANCE_**... I think **a struct would be the best choice.**  

If I would used a struct:
- the **Model would only contain the properties** (currentValue, targetValue, score, round, points and the computed property (difference).
- I would implement **all the needed methods** to use the model **in the  controller**.

---


## RGB Bull´s Eye
| ![gif light](/Week02/Assets-Gifs/RGBullsEyeLight.gif) | ![gif dark](/Week02/Assets-Gifs/RGBullsEyeDark.gif) |
| ------------------------------------------------------- | ----------------------------------------------------- | 
| iPhone in Light mode | iPhone in Dark mode |  



![AppIcon](/Week02/Assets-Gifs/RGBullsEye.png) 

|![iOS 13.0](https://img.shields.io/badge/iOS-13-orange)|
| ------------------------------------------------------- |
|![swift 5](https://img.shields.io/badge/Swift-5-red)|  


As requested, and in order to test it, I have used the same model I did in the previous exercise  (BullsEyeMVC)

I have made some minor changes to the exercise proposed in the assignment:  
- **Added a hint switch:** and **_I Love this one._** It will be showed if you get less than 95 points in your last 2 attempts to match (your last 2 rounds), and it will fade away after you get a score above it (≥ 95),
- Due to the previous one I have also **modified the AboutViewController text** adding the info about the "Hint"
- **Changed UI colours to conform both light and dark mode.**  
- **Changed the AlertView title and message attributes:** in order to be able to align the title and the message because
    **I have**...  
- ... **added the match colour original values** to this alert view to be able to know how far we get to achieve a one hundred per cent perfect match. 
- Added a **fade transition:** to improve the visuals just a little.

---

## Reversal Bull´s Eye

| ![AppIcon](/Week02/Assets-Gifs/RevBullsEye.png) | ![gif](/Week02/Assets-Gifs/RevBullsEye.gif) |
| ------------------------------------------- | ----------------------------------------------------- | 


|![iOS 13.0](https://img.shields.io/badge/iOS-13-orange)|
| ------------------------------------------------------- |
|![swift 5](https://img.shields.io/badge/Swift-5-red)|

**The goal here is continue testing the model we did in Bull´s Eye MVC.**  

This app is a reverse mode of Bull´s Eye, and here the slider gets a random value that we have to guess so:
- Now there is a **Text Field** (instead of a Label) **where** we can **"guess" the value of the slider**,
- In order to input our guessed value we have to use the Keyboard (numeric),
- which one will be **dismissed tapping anywhere outside of it** (the keyboard).
- Also owns the **fade transition** to improve visuals.

