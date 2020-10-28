# My Recipe Box (MVP in Progress)

## Overview
- Recipes are fetched from the Spoonacular Recipe API: https://spoonacular.com/food-api
- A native Swift iOS application using UIKit.

## Screens
(Screenshots coming soon)

- The **Auth Screens** include the Home Screen, Sign Up Screen and Login Screen. 

- The **Browse Screen** has a search bar and a collection view. Searching for a keyword in the search bar will load a list of recipes into the Collection View. Each cell displays the recipe's image with a bookmark icon in the upper right corner, the recipe's title and the number of servings.

- The **Detail Screen** has the recipe's image, title and listed dietary categories. 

## Currently Working on
- Refactor the dietary labels and method in the Detail Screen.
- Implement SafariServices which allows web views in app. When the "Cooking Instructions" button is pressed in the detail screen, it will navigate to the recipe on line. 
- Add summary of the dish to the Detail Screen. 
- Persist bookmarked recipes and populating the items in the BookmarkedItems Screen. 

## Screenshots
![image](images/HomeScreen.png) ![image](images/SearchScreen.png)

## Future Implementations
- Dark Mode
- Landscape Mode
- Create own recipe card
- Share favorited recipes with others

## Language
Swift 5

## Cocoa Frameworks
- Foundation
- UIKit

## Third-Party Frameworks
- Firebase/Auth
- Firebase/Firestore
- Firebase/Storage

## Development Tools
- Xcode 11
