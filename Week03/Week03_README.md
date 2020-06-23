# WEEK 3  (Monday 8th June to Sunday 14th June)

## Cryptly app 

This week is more about the code than the layout (use of protocols, named types, extensions...)  

**In order to refactor the setupViews() function:**
- I have created a final class named **WidgetView** that **inherit from UIView and comforms to Roundable protocol**. This way I am able to apply round squares directly to the widgetViews. It also has a method to set the components that are equal to all Views.
- I also **grouped all the WidgetViews in an array**, and **the labels**  with *common components* **in another one**. This way I can use `.forEach {....}` to set in one line all the WidgetViews and all the "normal" labels. Falling and Rising values have special textColor so both are set in another way.


**Roundable protocol:**
- In order to make Roundable protocol only conform to UIView I have declared it as `protocol Roundable where Self: UIView {}`
-  I've created a property for the corner radius value `var cornerRadius: CGFloat {get set}`. I have included `set` in order to be able to use a method to update this value if necessary (I used it to give different corner radius to each WidgetView).
- Due to this **cornerRadius** is a **stored property** I need to **conform WidgetView class to Roundable** protocol, **instead of use an extension** to add Roundable to WidgetView class.
- WidgetView class also includes `func round()` method (to apply the cornerRadius value) and,
- `func setCornerRadius(to: radius: CGFloat)`in order to update its value (because it is declared as `internal` to avoid unnespected value changes).
