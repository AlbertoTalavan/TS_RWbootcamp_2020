**Compatibility Slider:** 
Curent status:
  - [x] In progress at this very moment ...
  - [x] finished ...
  - [x] Extra Unit Testing ...
  - [ ] readme complete.  

We have a partial project the one we have to finish (fixing uy, completing logic and so on...).

#### Well, referred to the **"UI"** aspect of the app I did the following updates:
- Added StackViws and constraints to Story Board:
  - **Upper VStack View** : this is a Vertical Stack View containing a "question label" and a "HStackView" (Horizontal Stack View).
  - **Slider Emoji VStack**: Vertical Stack View composed of an "Emojis HStack" and a slider.
  - **Button**: used to go through the next topic.
 - Also was given a touch of colour to made it a little nicer, and usable in both light and dark modes as well as land, portrait orientations.

#### For the **"Logic"** part what I did was:  
- Instead of only Two topics now we will have **between Two and Five of all the 15 different topics**.
```Swift
//inside the game Model...
func setTopicsNumber(howMany: Int.random(in: 2...5))

private func assignCompatibilitySubjects(){
      var subjectsChosen = [String]()
      var subjectsFree = subjects
      //subjectsFree.append(contentsOf: subjects.map { $0 })
      
      var randomIndex = 0
      for _ in 1...howManyTopics {
         randomIndex = Int.random(in: 0 ..< subjectsFree.count)
         subjectsChosen.append(subjectsFree.remove(at: randomIndex))
      }
      compatibilityItems.append(contentsOf: subjectsChosen)
   }
```
- **Value of the slider was kept between 1 and 5** as it was originally designed: this way the **minimum compatibility score** we are able to obtain **will be 20%**.


- Have been **introduced "compatibility zones"**: this way **each "zone" will display a different value for tittle, message and action button text** during test results, 

```Swift
//inside view Controller
func getTitleAndMessage () -> (String, String, String)  {
    //some code....
    switch  compatibility { 
      case 0...29:              //each case corresponds a each "compatibility zone"
        //code...
      case 30...49:
         //code...
      case 50...69:
        //code...
      case 70...89:
        //code...
      case 90...100:
        //code...
      default:
         break
      }
```

- Those three  **String objects will be stored in a tuple** inside the alert view just **to use them when required**.
```Swift 
  //this shows an alert view
   func showResults () {
      let stringsTuple: (title: String, message: String, action: String) = getTitleAndMessage()
      
      let alert = UIAlertController(title: stringsTuple.title, message: stringsTuple.message, preferredStyle: .alert)
     
      //same use of stringsTuple for the action button
      
      alert.addAction(action)
      
      present(alert, animated: true)
  }
}

```
- **First Results** View will be shown (an AlertView) and **later** ,after pressing the "ok" action button, **the game will be reset**.  


- In order **to avoid crashes due to "index out of range"** when we are looking at `compatibilityItems[currentItemIndex]` : and due to in my app we will have between 2 and 5 items
I use a metod that compares the max number of items and if the index is bigger than it, this index will be reset to its initial value (zero) 
```Swift 
//inside the game Model...
func updateCurrentItemIndex() {
      compatibilityItems.count > (currentItemIndex + 1) ? (currentItemIndex += 1) : resetCurrentItemIndex()
   }
```

  

