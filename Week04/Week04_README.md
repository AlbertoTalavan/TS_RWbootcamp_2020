# Week 04 (Monday 15 June to Sunday 21 June)
 
**Debugging Comparison Shopper:**  
We are given a chrashing app and our mission is to solve a pair of three of sneaky problems we face:

- The app does not run. That was produced because of some problems:
  - **house1 was not instantiated**, it was created as an optional `var house1: House?` but never instantiated,
  - and was called even before of gave it values for its properties (as shown in the followin lines of code):
  ```Swift
  //this is the original version of viewDidLoad()
  override func viewDidLoad() {
      super.viewDidLoad()
      
      setUpLeftSideUI()  //does not controll the nil value for house1 => that means "lots of problems"
      setUpRightSideUI() //No problems here, inside it the nil value is taken in consideration
  
      house1?.price = "$12,000"
      house1?.bedrooms = "3 bedrooms"
   }
  ```  
  
  - it also had not have a value for its address property... so I added it -> `house1?.address = "3898 Melody Ln, Santa Clara CA"`. Now viewDidLoad() looks as follows:
  ```Swift
  //this is the Final version of viewDidLoad()
  override func viewDidLoad() {
            super.viewDidLoad()
            
          house1 = House()
            
          house1?.address = "3898 Melody Ln, Santa Clara CA"
          house1?.price = "$12,000"
          house1?.bedrooms = "3 bedrooms"
          
          setUpLeftSideUI()
          setUpRightSideUI()
        }
   ```
  - In **func setUpLeftSideUI()**: As we did not have instatiated the variable house1, one problem was here because this function forces the unwrapping of house1 and its properties  (i.e. `priceLabelLeft.text = house1!.price!`). Instead of instantiate house1 on `viewDidLoad()` we could have taken the possibility of use:
    - if let / guard let : for a secure unwrap of house and its properties, or 
    - conditional operator ?: `priceLabelLeft.text = house1?.price`, but with this solution we still having a house1 nill value and, although the app will not crash and will run, it will not show any values on the labels...(simply because there is no values to attach to the `.text` attribute of each label).  
  - Inside the alert view we also have a minor problem: if we do not type anything inside the TextFields, we will have an String equal to "", this way when we go back to `setUpRightSide()` the values asociated to the house2 Labels will have a text equal to "", not showing nothing. I added the following piece of code to substitute those empty TextFields by a default String... take a look at the code below:
  ```Swift
  //this code goes inside the Action on the Alert View
    alert.textFields?.forEach { //checking for non "" values in textfields
                  if $0.text == "" { $0.text = "\(String(describing: $0.placeholder!)) not available" }
               }
  ```
  
  - That done, it was necessary to **fix the connection between the IBOutlet** of one of the Labels **and its corresponding StoryBoard Label**.
 
- Once we have the app running, when we press the button to add the second house, and after pressing the "ok" button on the displayed alert view, the new house was never showed on screen:
  - That bug was the result of the setting of the **alpha channel of both Labels and the ImageView**. First time we go through the function involved in showing the data of that second house `setUpRightSideUI()`, as we start the app, **house2 is not instantiated yet**, so this functions set the **alpha channel values** of all the labels and the imageView **equal to zero**. Later, when **we come back to this function**... we were not **re-setting the value of those alpha channels**, sot them will still set to zero forever. Changing the alphay channel to its max value (1.0) when house2 is not nill, solves this bug.

--- 

**Compatibility Slider:** 
  - [ ] In progress ...
