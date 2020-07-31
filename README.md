# AzureOverall: Eat at a Distance

## Overview

For the good of the public, it is important that people maintain social distancing. That means fewer trips to the supermarket, where aisles can often be less than six feet apart. As a result, small markets and vendors are feeling the pain of a drop in revenue.

Pursuit Farms is building a delivery service to rescue their business. They've contracted you to create the prototype of their new app, AzureOverall. Using AzureOverall, a user should be able look through available recipes and add as many as they would like to their cart. Payment and delivery will be handled by a third-party service.  



## Requirements

- The app must be implemented as a native iOS application. Either Swift or Objective-C are acceptable.
- Recipes should be fetched from the Spoonacular Recipe API: https://spoonacular.com/food-api
- At least three screens should be implemented: A **Browse Screen**, a **Cart Screen**, and a **Detail Screen**.
- The **Browse Screen** should have a search bar and a collection view. By default, nothing should be loaded. Searching for a keyword in the search bar should load a list of recipes into the Collection View. Each cell should display the recipe's image, the recipe's title, the number of servings, and the time it takes to prepare.
- The **Cart Screen** should have a table view. Each cell should display the title of the recipe, its image, and the current number of times it has been added to the cart. 
- Selecting a cell in the Browse Screen or in the Cart Screen should navigate to a Detail Screen for that item. 
- The **Detail Screen** should display the title and image of the recipe. It should display the number of items of this kind currently in the cart, and should include a stepper that allows the user to add/remove multiple items to/from their cart. 
- Changes from the Detail Screen should be available and visible throughout the app after each launch.


## What We Are Looking For

- Clean, well-architected, intuitively-named code. Code will be passed through a linter like [SwiftLint](https://github.com/realm/SwiftLint) for plagiarism detection. 
- Intuitive and well-designed user interface
- Displaying collections of information
- Network requests
- Memory management
- Multithread processing
- Using the `Data` type
- Source control


## Bonus Features

- A “Start cooking” button on the Cart Screen that starts counting down until food is done.
- Allowing the user to search by a specific `diet` in the Browse Screen
- Animations for adding elements to your cart
- Sections in the Browse Screen that separate recipes by how much time it will take to make them.  Include at least 3 sections (Ex: "Quick", "Reasonable", "Time-Intensive").
