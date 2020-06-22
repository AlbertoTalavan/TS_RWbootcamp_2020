**Week 04 (Monday 15 June to Sunday 21 June**
 
## Debugging Comparison Shopper: 
We are given a crashing app and our mission is to solve a pair or three sneaky problems we will face.  


- The app does not run. That was produced because of some problems:
  - **house1 was not instantiated**: it was **created as an optional** `var house1: House?` **but never instantiated**,
  - and it was **called** even **before** of **giving it values for its properties** (as shown in the followin lines of code):
  ```Swift
  //this was the original version of viewDidLoad()
  override func viewDidLoad() {
      super.viewDidLoad()
      
      setUpLeftSideUI()  //DID NOT control the nil value for house1 => that means "lots of problems"
      setUpRightSideUI() //No problems here, inside it the nil value WAS taken in consideration
  
      house1?.price = "$12,000"
      house1?.bedrooms = "3 bedrooms"
   }
  ```  
  
  - it also **had not have a value for its address property**... so I added it -> `house1?.address = "3898 Melody Ln, Santa Clara CA"`. Now viewDidLoad() looks as follows:
  ```Swift
  //this is the Final version of viewDidLoad()
  override func viewDidLoad() {
            super.viewDidLoad()
            
          house1 = House()     //instance of House() 
            
          house1?.address = "3898 Melody Ln, Santa Clara CA"  //Adding this one we will not have any nil value for  
          house1?.price = "$12,000"                           // each of the three properties
          house1?.bedrooms = "3 bedrooms"
          
          setUpLeftSideUI()      //Now we ARE ABLE to go through this methdo without "problems"
          setUpRightSideUI()
        }
   ```
  - In **func setUpLeftSideUI()**: As we did not have instatiated the variable house1, one problem was here because this function forces the unwrapping of house1 and its properties  (i.e. `priceLabelLeft.text = house1!.price!`). Instead of instantiate house1 on `viewDidLoad()` we could have taken the possibility of use:
    - **if let / guard let**: for a secure unwrap of house and its properties, or 
    - **conditional operator ?**: `priceLabelLeft.text = house1?.price`, but with this solution we still having a house1 nill value and, although the app will not crash and will run, it will not show any values on the labels...(simply because there is no values to attach to the `.text` attribute of each label).  
    
    
  - We can find **another**, in this case, **minor bug in** the action of **the Alert View**: if we type nothing inside the TextFields, we will have an String equal to "" (an empty string), this way when we go back to `setUpRightSide()` the **values asociated to the house2 Labels will have an empty text (""), showing nothing**. I **added** the following piece of **code to substitute those empty TextFields with a default String*... take a look at the code below:
  ```Swift
  //this code goes inside the Action on the Alert View
    alert.textFields?.forEach { 
    //checking for "" values in textfields (empty values means we didn´t type anything inside them)
         if $0.text == "" { $0.text = "\(String(describing: $0.placeholder!)) not available" }
    }
  ```
  
  - That done, it was **necessary** to **fix the connection between the IBOutlet** of one of the Labels **and its corresponding StoryBoard Label**.
 
- Once we have the app running, when we press the button to add the second house, and after pressing the "ok" button on the displayed alert view, the new house was never showed on screen:
  - That bug was the result of the setting of the **alpha channel of both: Labels and the ImageView**. First time we cal the method involved in showing the data of that second house `setUpRightSideUI()`(just when we start the app) **house2 is not yet instantiated**, so this functions set the **alpha channel values** of all the labels and the imageView **equal to zero**. Later, when **we come back again to this method**... we were not **re-setting the value of those alpha channels**, so them will still set to zero forever. **Changing the alpha channel to its max value** (1.0) *when house2 is not nill*, **solves this bug**.

And that´s all for this app.  

**The app code is also comented for a faster understanding.**  


#
#
#

>v1.1