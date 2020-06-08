# WEEK 2  (Monday 1st June to Sunday 7th June)

This week assignments :
- **Bull´s Eye MVC:** this one is mandatory, 
- **RGB Bull´s Eye:** this one is also mandatory,  
- **Reversed Bulls Eye:** I know, you are thinking of mandatoriness of this one too...  
                       but....NOPE!!, this is the optional one ...SURPRISE!!!! 
                       I´m pretty sure you didn´t expect it LoL.
---
###Bull´s Eye MVC
I have used a class (instead of a struct) because of the following reasons:
- **I want to define the game as a constant:** during the game ALL the properties of the model will change... with a struct It is necessary to declare it (the game) as a variable -> even if I use  let properties in the struct and also  mutating functions to be able to change the value of those properties... I will need to declare the struct as a variable  
-**I want to keep `private` the game properties:** In order to avoid freely access to its properties, and with the thought of dodging some errors if we operate them directly. In order to read/write this properties  it will be mandatory to do it through the functions available for that purpose  (getters/setters). There is also a computed property that only needs to be read (through a getter) due to we do not need to write it from outside the model.  

That said, **as I am NOT using  INHERITANCE**... I think **a struct would be  the best choice**


