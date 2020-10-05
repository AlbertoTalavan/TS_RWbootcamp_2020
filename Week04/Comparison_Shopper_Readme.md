**Week 04.**
 
### Debugging Comparison Shopper: 
We are given a crashing app and our mission is to solve a pair or three sneaky problems we will face.  
<p align="center"> <!-- using the assets directory -->
  <img src="/Week04/Assets/pic01Comparison.png" height="500"/>
	<img src="/Week04/Assets/pic02Comparison.png" height="500"/> 
	<img src="/Week04/Assets/pic03Comparison.png" height="500"/>
</p>

- The app does not run. That was produced because of some problems:
  - **house1 was not instantiated**: it was **created as an optional** `var house1: House?` **but never instantiated**,
  - and it was **called** even **before** of **giving it values for its properties*.
  - it also **had not have a value for its address property**.
  - In **func setUpLeftSideUI()**: As we did not have instatiated the variable house1, one problem was placed here, because this function forces the unwrapping of house1 and its properties. Instead of instantiate house1 on `viewDidLoad()` we could have taken the possibility of use:
    - **if let / guard let**: for a secure unwrap of house and its properties, or 
    - **conditional operator ?**: `priceLabelLeft.text = house1?.price`, but with this solution we still having a house1 nill value and, although the app will not crash and will run, it will not show any values on the labels...(simply because there is no values to attach to the `.text` attribute of each label).  

  - We can find **another minor bug in** the action of **the Alert View**: if we type nothing inside the TextFields, we will have an String equal to "" (an empty string), this way when we go back to `setUpRightSide()` the **values asociated to the house2 Labels will have an empty text (""), showing nothing**. I **added** **a piece of code to substitute those empty TextFields with a default String**.
  - That done, it was **necessary** to **fix the connection between the IBOutlet** of one of the Labels **and its corresponding StoryBoard Label**.
 
- Once we have the app running, when we press the button to add the second house, and after pressing the "ok" button on the displayed alert view, the new house was never showed on screen:
  - That bug was the result of the setting of the **alpha channel of both: Labels and the ImageView**. First time we call the involved method in showing the data of that second house `setUpRightSideUI()`(just when we start the app) **house2 is not yet instantiated**, so this method sets the **alpha channel values** of all the labels, and the imageView, as **equal to zero**. Later, when **we came back again to this method**... we were not **re-setting the value of those alpha channels**, so them will still being set to zero forever. **Changing the alpha channel to its max value** (1.0) *when house2 is not nill*, **will solve this bug**.

And that´s all for this app.  
