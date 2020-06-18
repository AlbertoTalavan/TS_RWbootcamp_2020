# Week 04 (Monday 15 June to Sunday 21 June)
 
**Debugging Comparison Shopper:**  
We are given a chrashing app and our mission is to solve all the problems we face:

- The app doesn´t run. That was produced because some problems:
  - **house1 was not instantiated**, it was created as optional `var house1: House?` but never instantiated,
  - it also had not have a value for its address property... so I added it -> `house1?.address = "3898 Melody Ln, Santa Clara CA"`
  
  - In **func setUpLeftSideUI()**: As we did not have instatiated the variable house1, one problem came because this function forces the unwrapping of house1 and its properties  (i.e. `priceLabelLeft.text = house1!.price!`). Instead of instantiate house1 on `viewDidLoad()` we could have taken the possibility of use:
    - if let / guard let : for a secure unwrap of house and its properties, or 
    - conditional operator ?: `priceLabelLeft.text = house1?.price`, but with this solution we still having a house1 nill value and, although the app will not crash and will run, but will not show any values on the labels...
  
  - That done, it was necessary to **fix the connection between the IBOutlet** of one of the Labels **and its corresponding StoryBoard Label**.
 
- With the app running, when we press the button to add the second house, after pressing the "ok" button on the alert view, the new house was never showed on screen:
  - The problem here was the **alpha channel of the Labels and the ImageView**. First time we go through the function involved in showing the data of this second house (`setUpRightSideUI()`), as we start the app, **house2 is not instantiated yet**, so this functions set the **alpha channel values** of all the labels and the imageView **equal to zero**. Second and following times **we come back to this function**... we were not **re-setting the value of those alpha channels**
  
 
  
<br>  
--- 
<br>
**Compatibility Slider:** 
  - [ ] In progress ...
