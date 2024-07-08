# marvel_swiftui

  

****marvel_swiftui**** is a SwiftUI App that uses the Marvel API to display a list of Marvel characters and their details.

  

## About

This App was created as a personal project to showcase my skills and passion for iOS development, with the goal of demonstrating best implementation practices for iOS Apps using ****SwiftUI****, ****MVVM****, ****Dependency Injection****, ****Unit Testing**** and more.

  

## Screenshots

  <img src="https://github.com/guisilvaa/marvel_swiftui/assets/4164347/f2077e12-35a2-4863-8c69-1fb97f268a22" width="420">



<img src="https://github.com/guisilvaa/marvel_swiftui/assets/4164347/019a232b-e603-40e9-bb60-fecf530504ef" width="420">

  

## Project Structure

This project is separated into layers as follows:

  

### Commons

Contains the ****network layer****, responsible for making API calls; ****router****, responsible for the navigation between screens; and ****view**** that contains the async state view responsible to handle the view states

  

### Character

Contains the UI responsible for presenting the data to the user and handling user interactions. It also contains the ViewModels, which are responsible for preparing the data to be presented the handling of interactions between the view and the use cases.

  

### Resources

Contains the images, colors e json files used to mock responses

  

## Development Environment

```

Xcode 15.3

Swift 5.8.1

iOS Deployment Target 17.0

```
```
