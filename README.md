# RECIPE
PROJECT PLAN (RECIPE APP)

Description
Allows users to view a list of recipes and select what recipe they need for their dish. They can decide based on the nutrients they want, calories, price, etc.
App Evaluation
Category: Food
Mobile: This app would be primarily developed for mobile but would perhaps be just as viable on a computer, such as green chef or other similar apps. 
Story: Users will be able to create a better kitchen experience by making tastier results and those who eat with him/her will be attracted to the app.
Market: This app literally turns a smartphone into a cookbook since people are nutrient conscious.
Habit: This app could be used as often or often as the user wanted depending on what they eat.
Scope: First users would be able to see a list of recipes and will be able to add it to their shopping list and later be able to make payments.
Product Spec
1. User Stories (Required and Optional)
Required Must-have Stories
User logs in to the recipe app
Users can pick any recipe
Able to see list of recipes on home screen and a filter and sort section
Users will be able to see recommended recipes
Settings (Personal Info, Address, General, Price Info ,etc.)
Optional Nice-to-have Stories
Allows users to make payments
2. Screen Archetypes
Login
Recipe Selection screen - Allows users to see their recipe and ingredients
Register - User signs up or logs into their account
Upon Download/Reopening of the application, 
Home Screen.
Allows users to be able to see a list of recipes and be allowed to add it to their shopping cart.
Settings Screen
Lets people change language, and app notification settings.
3. Navigation
Tab Navigation (Tab to Screen)
Home Screen
Profile
Settings
Flow Navigation (Screen to Screen)
Forced Log-in -> Account creation if no login is available
Profile -> Text field to be modified.
Settings -> Toggle settings



API’S I’LL BE USING 
SUGGESTIC API - ​​https://suggestic.com/signup.html
THEMEAL DB API - https://www.themealdb.com/api.php

Food nutrition info


Model User
Property
Type
Description
email


string
Users email
username
string
Users username
password
string
Users password





















Model Ingredient
Property
Type
Description






name
string
Name of ingredient
Recipe ingredient
string
Name of ingredient
Ingredient quantity
number
Number of ingredient














Model Recipes
Property
Type
Description






Recipe name
string
Name of recipe
calories
number
Number of calories





















