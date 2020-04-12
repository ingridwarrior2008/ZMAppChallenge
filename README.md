# ZMAppChallenge

ZMAppChallenge App show the posts from https://jsonplaceholder.typicode.com. 
The project was built in Xcode version 11.4 and iOS 13.4

![Screen Recording 2020-04-11 at 4 37 32 PM_2](https://user-images.githubusercontent.com/1762283/79055823-9be73600-7c15-11ea-989a-616451b3dc8a.gif)

## How to Run
- In the root folder run `pod install` after that you can open the `ZMAppChallenge.xcworkspace` file. Finally go to Product > Run 

- To run the tests you can use the shortcut `cmd + u` or in Xcode menu go to Product > Test

## App Architecture
the app uses **MVVM** Architecture

## Dependencies (Pods)
- Lottie: a library to load animations from a JSON file, the animations that were used in the project you can found in this link https://lottiefiles.com 

- ReachabilitySwift: a library to check network connectivity.

## Folder Structure

```
.
├── AppDelegate.swift
├── Common
│   ├── Connectivity
│   │   ├── ZMConnectivityHandler.swift
│   │   ├── ZMStringExtensions.swift
│   │   └── ZMUIViewControllerExtensions.swift
│   ├── Constants
│   │   └── ZMAppGlobalConstants.swift
│   ├── Protocols
│   │   ├── ZMDataSourceProtocol.swift
│   │   ├── ZMTableViewCellProtocol.swift
│   │   └── ZMViewModelServiceProtocol.swift
│   └── Views
│       └── Lottie
├── DataManagers
│   ├── API
│   │   ├── ZMDataManagerNetworkProvider.swift
│   │   └── ZMNetworkBuilder.swift
│   └── Protocols
│       └── ZMDataManagerNetworkProtocol.swift
├── Info.plist
├── Modules
│   ├── Post
│   │   ├── Models
│   │   ├── ViewControllers
│   │   ├── ViewModels
│   │   └── Views
│   └── PostDetail
│       ├── Models
│       ├── ViewControllers
│       └── ViewModels
├── Resources
│   ├── Assets
│   │   └── Assets.xcassets
│   ├── CoreData
│   │   └── ZMAppChallenge.xcdatamodeld
│   ├── JSON
│   │   └── Animations
│   ├── Locale
│   │   └── Localizable.strings
│   └── Storyboards
│       └── Base.lproj
├── SceneDelegate.swift
└── Services
    ├── Comment
    │   └── ZMCommentManagmentService.swift
    ├── Post
    │   └── ZMPostManagmentService.swift
    └── User
        └── ZMUserManagmentService.swift
```
