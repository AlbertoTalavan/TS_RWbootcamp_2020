# WEEK 1 apps (Monday 25 to Thursday 28 of 2020)
 - **Bull´s Eye:** Assigment from Monday 25 to Thursday 28 -> App resulting of following the "Your First iOS and UIKita App"
                RayWenderlich.com webpage.  
 - **01-rgbColorPicker:** Assignment from Thursday 28 to Monday 1 of June -> **First assignment to do on our own**.

---
---

## 01-rgbColorPicker app
I have made some changes to the original assignment:  
- The sliders default position is the one that make the white colour in each color model (rgb:255,255,255 or hsb:0,0,100).
  That is because iOS devices can be in light or dark mode and **I am using UIColor.Label for the app texts**. That means
  if the **device is in light mode** and the **sliders default** to the leftmost position...(that **means black color** in 
  both rgb and hsb) we will not be able to read any text of any label at this momment because the "Label" color for
  "light mode" is black
- The background of the app is changing color in real time as we move any slider. I think it is a better way of see what is
  happening as you move any one of the sliders
- When int the AlertView we hit the ok action (called "like it") we do not assign the colour to the background, instead **we**
  **assign the colour to a view containing the Color Name Label** where we are showing the name we just gave to that colour. 
  This is because as we are changing constantly the background color the only way to maintain our last "setted color" in 
  the UI is keeping it in some place... and I think this view is almost the best one!  
  
  
  
#### The original assignment:
The task is to create an app that allows users to color the background of the app. To do that we will choose between RGB or HSB (both are different color model representations) and using the 3 different components of the model of our election we will create this background color.

The UI should consist of the following:
- A label near the top of the view (for displaying a color name)
- 3 Sliders, one representing each color range
- A label above each slider (Used to indicate what that slider is for)
- 3 labels, each positioned next to a slider, capable of displaying a string
- A button called “Set Color”
- A button called “Reset”

The sliders should default to the leftmost position, and the labels should show 0 by default. The title labels above the sliders should read “Red”, “Green” and “Blue” (or "Hue", "Saturation" and "Brightness if HSB) in that order.

When moving a slider, the label to its right should update with an integer in the range of values for each component of the selected color model representation.

When the “Set Color” button is hit, an alert should appear asking the user to enter a color name (the name doesn’t control the color - it’s just a label like ‘my color’!). Once a name is entered and the user presses “Enter” on the keyboard, the background of the app should change to a color corresponding to the RGB values entered by the sliders and their color name should appear in the top label. The alpha value should be hard-coded to 1.0, as we won’t be addressing transparency here.

When “Reset” is hit, the sliders, labels and background color should return to the default values.

The app should have a splash screen and app icon (see Resources below).
The app should work in landscape and portrait orientation.
The app should have an info button that presents the wikipedia page for RGB. That page should have a Close button to dismiss it.
