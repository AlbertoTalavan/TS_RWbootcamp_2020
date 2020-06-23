# WEEK 1 apps (Monday 25 to Thursday 28 of 2020)


## 01-rgbColorPicker app  
#### (first assignment to do on our own)

| ![gif light](/Week01/Assets-Gifs/ColorPicker-light.gif) | ![gif dark](/Week01/Assets-Gifs/ColorPicker-dark.gif) |
| ------------------------------------------------------- | ----------------------------------------------------- | 
| iPhone in Light mode | iPhone in Dark mode |




|![iOS 13.0](https://img.shields.io/badge/iOS-13.0-orange)|
| ------------------------------------------------------- |
|![swift 5](https://img.shields.io/badge/Swift-5-red)|

**Previous considerations**  
I used the AutoLayout and the StoryBoard as required for this assignment. It is optimized for and iPhone SE screen size but 
it can be run on any iPhone supporting iOS13.  

I could adjust the screen for any screen resolution doing it programatically but I choose do it with StoryBoard just to 
practice the *AutoLayout* there and the *vary for traits* ...but I will to improve it ^^!

I have made some changes to the original assignment (and here is why):  
- The sliders default position **now is different** depending of the light or dark mode the device is when it runs the
  app. If the **device is in light mode** then the **default value will be black** (rgb:0,0,0 or hsb:0,0,0), and if the
  **device is in dark mode** then the **default value will be white** (rgb:255,255,255 or hsb:0,0,100).  
  That is because iOS devices can be in both light or dark mode and **I am using UIColor.Label for the texts**. That means
  If in example the **device is in light mode** and the **sliders default** to the leftmost position...(that **means**
  **black colour** in both rgb and hsb) **we will not be able to read any text of any label** because the ".Label" colour for
  "light mode" is black.
- The background of the app is changing colour in real time as we move any slider. I think it is a better way of see what is
  happening as you move any one of the sliders so,
- When, in the AlertView, we hit the ok action (called "like it") we do not assign the colour to the background, instead  
  **we assign the colour to a view containing the Color Name Label** where we are showing the name we just gave to that  
  colour. 
  This is because as we are changing constantly the background colour, the only way to maintain our last "setted colour" in 
  sight is keeping it in some place... and I think this kind of container view is almost the best one!  
- When you press the "info" button you go via segue to InfoViewController, but **depending of the color model selected at**
  **the moment you pressed it, the "webView" will show you the wikipedia info page for rgb or hsb** ... and,
- the "close" button **will have its background color equal to "reset" and "set color" buttons**.


