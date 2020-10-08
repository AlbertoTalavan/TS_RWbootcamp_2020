# WEEK 03.

### Cryptly app 
Criptly is an app that parses all cryptocurrencies from an embedded JSON file, and shows them on a screen simulating widget-like view.  

<p align="center"> <!-- using the assets directory -->
  <img src="/Week03/Assets/pic01.png" height="500"/>
	<img src="/Week03/Assets/picLight.png" height="500"/> 
	<img src="/Week03/Assets/picDark.png" height="500"/>
</p>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0+-lightgrey.svg?longCache=true&?style=plastic&logo=apple)](https://developer.apple.com/ios/)

## Tech Stack
- Storyboard
- Autolayout
- UIKit
- Custom Light/Dark themes (

## Final considerations.  

**In order to refactor the setupViews() function:**
- I have created a final class named **WidgetView** that **inherit from UIView and comforms to Roundable protocol**. This way I am able to apply round squares directly to the widgetViews. It also has a method to set the components that are equal to all Views.
- I also **grouped all the WidgetViews in an array**, and **the labels**  with *common components* **in another one**. This way I can use `.forEach {....}` to set in one line all the WidgetViews and all the "normal" labels. Falling and Rising values have special textColor so both are set in another way.


**Roundable protocol:**
- In order to make Roundable protocol only conform to UIView I have declared it as `protocol Roundable where Self: UIView {}`
-  I've created a property for the corner radius value `var cornerRadius: CGFloat {get set}`. I have included `set` in order to be able to use a method to update this value if necessary (I used it to give different corner radius to each WidgetView).
- Due to this **cornerRadius** is a **stored property** I need to **conform WidgetView class to Roundable** protocol, **instead of use an extension** to add Roundable to WidgetView class.
- WidgetView class also includes `func round()` method (to apply the cornerRadius value) and,
- `func setCornerRadius(to: radius: CGFloat)`in order to update its value (because it is declared as `internal` to avoid unnespected value changes).
