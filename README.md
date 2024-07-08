# marvel_swiftui

marvel_swiftui is a SwiftUI app that uses the Marvel API to display a list of Marvel characters and their details.
This app is created as a personal project to showcase my skills and passion for iOS development. This app demonstrates how to implement some of best practices for iOS app development using SwiftUI, MVVM, Dependency Injection, Unit Testing and more.

Screenshots

![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 15 51 44](https://github.com/guisilvaa/marvel_swiftui/assets/4164347/019a232b-e603-40e9-bb60-fecf530504ef)
![Simulator Screenshot - iPhone 15 Pro - 2024-07-08 at 15 50 21](https://github.com/guisilvaa/marvel_swiftui/assets/4164347/f2077e12-35a2-4863-8c69-1fb97f268a22)

Project Structure

This project is separated into this layers:

Commons: Contains the network layer responsable for making API calls, router responsable for the navigation between screens and view that contains the async state view responsable to handle the view states
Character: Contains the UI responsible for presenting the data to the user and handling user interactions. It also contains the ViewModels, which are responsible for preparing the data to be presented and for handling the interactions between the view and the use cases.
Resources: Contains the images, colors e jsons files used to mock responses

Development Environment

Xcode 15.3
Swift 5.8.1
iOS Deployment Target 17.0
