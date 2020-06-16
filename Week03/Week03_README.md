# WEEK 3  (Monday 8th June to Sunday 14th June)

## Cryptly app 

In this ocasion is more about the code than the layout (use of protocols, named types, extensions...)  

In order to refactor the setupViews() function:
- I have created a final class named **WidgetView** that **inherit from UIView and comforms to Roundable protocol**. This way I am able to apply round squares directly to the widgetViews. It also has a method to set the components that are equal to all Views.
- I also **grouped all the WidgetViews in an array**, and **the labels**  with *common components* **in another one**. This way I can use `.forEach {....}` to set in one line all the WidgetViews and all the "normal" labels. Falling and Rising values have special textColor so both are set in another way.


Roundable protocol:
-I created a property for the corner radius value `var cornerRadius: CGFloat {get set}`. I have included `set` in order to be able to use a method to update this value if necessary (I used to give different corner radius to each WidgetView-
- It also have the `func round()`method and,
- `func setCornerRadius(to: radius: CGFloat)`in order to update the cornerRadius value (because it declared as `internal` to avoid unnespected changes.

