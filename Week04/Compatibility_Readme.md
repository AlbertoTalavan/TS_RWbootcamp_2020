**Week 04 (Monday 15 June to Sunday 21 June**  

## Compatibility Slider: 

The task consists in finishing a partial project (fixing UI, giving it logic, etc.):  

#### As for the **UI** of the app I did the following updates:
- I have **created a CompatibilityGame Model** which is the Model of the app.  

- Control between the Model and the UI is permormed on the Controller (our viewController in the app), BUT **I added a `func restart()`method to the Model** just because in my opinion **the model should be able to control** it initial state during the game, I mean **not all the states** but **at least the initial one (the reset())**, performing the default operations to prepare it to be used by the Controller. The controller is who gives the order to reset it (it made a call to reset() using the game object instantiated in it, and takes control of other settings that are being controlled by itself).
```Swift
//inside the viewController
func restart() {
      
      game.reset() //Call the reset() Method of the model
   
      currentPerson = game.getPerson1()                           //sets currentPerson to person1
      
      questionLabel.text = "User 1, what do you think about..."   //default message
      compatibilityItemLabel.text = game.getCompatibilityItem()
      
      updateStarBorderWidth(for: leftStar)  //this controls which star is taking the "frame" (left start means user 1)
      
      slider.value = 3.0 //default value
   }

```

- Added StackViws and constraints to Story Board:
  - **Upper VStack View** : this is a Vertical Stack View containing a "question label" and a "HStackView" (Horizontal Stack View).
  - **Slider Emoji VStack**: Vertical Stack View composed of an "Emojis HStack" and a slider.
  - **Button**: used to step into the next topic.
 - A **touch of color was given** to made it a little nicer, and usable, in both **light and dark modes** as well as **land and portrait orientations**.
 - Even **a "frame" was added to** the left and right **stars image views**: **The goal of this frame is to help visualizing which player owns the turn at any moment as follows:
   - User 1 round......: left star has the frame. The frame will be hidden for the other one.
   - turn for User 2...: now the right star is the only one who has the frame. 

#### For the **"Logic"** part what I did was:  
- Instead of only two topics, now we will have randomly choosen **between Two and Five**, chosen **from the** all **15 different topics**.
```Swift
//inside the game Model...
func setTopicsNumber(howMany: Int.random(in: 2...5))    //each new play we will have a random set of topics between 2 and 5

private func assignCompatibilitySubjects(){
      var subjectsChosen = [String]()            //stores the subjects already selected
      var subjectsFree = subjects                //stores the subjects we still have to choose 
      
      var randomIndex = 0
      for _ in 1...howManyTopics {
         randomIndex = Int.random(in: 0 ..< subjectsFree.count)
         subjectsChosen.append(subjectsFree.remove(at: randomIndex))   //with remove(at:) we assure we will not have repeated topics
      }
      compatibilityItems.append(contentsOf: subjectsChosen)
}
```
- **Value of the slider was kept between 1 and 5** as it was originally designed: this way the **minimum compatibility score** we are able to obtain **will be 20%** ... We do not want to potentially discourage future couples you know ^_^!.


- Have been **introduced "compatibility zones"**: this way **each "zone" will display a different value for tittle, message and action button text** during test results, 

```Swift
//inside view Controller
func getTitleAndMessage () -> (String, String, String)  {
    //some code....
    switch  compatibility { 
      case 0...29:              //each case corresponds a each "compatibility zone"
      
      // more case sentences...
      
      default:
         break
      }
}
```

- Those three  **String objects will be stored in a tuple** inside the alert view just **to use them when required**.
```Swift
//inside view Controller
  
func showResults () { //this shows an alert view
   
      let stringsTuple: (title: String, message: String, action: String) = getTitleAndMessage()
      
      let alert = UIAlertController(title: stringsTuple.title, message: stringsTuple.message, preferredStyle: .alert)
     
      //same use of stringsTuple for the action button
      
      alert.addAction(action)
      
      present(alert, animated: true)
  }
}

```
- **First Results** View will be shown (it is an AlertView), and **later** ,after pressing the "ok" action button, **the game will be reset**. 
(The assignment specified the opposite... but I think this way the UI is less confusing).


- In order **to avoid crashes due to "index out of range"** when we are looking at `compatibilityItems[currentItemIndex]` : and because of the randomly number of chosen topics (items) I have implemented, I use a method that compares the max number of items and if the index is bigger than that, this index will be reset to its initial value (zero), otherwise this index is incremented by 1. Take a look at the code below.
```Swift 
//inside the game Model...
func updateCurrentItemIndex() {
      compatibilityItems.count > (currentItemIndex + 1) ? (currentItemIndex += 1) : resetCurrentItemIndex()
}
```

And that is the most important things about this app. 

**The app code is also commented for a faster understanding.**



>v1.0

  

