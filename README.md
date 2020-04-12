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
├── Podfile
├── Podfile.lock
├── Pods
│   ├── Headers
│   ├── Local\ Podspecs
│   ├── Manifest.lock
│   ├── Pods.xcodeproj
│   │   ├── project.pbxproj
│   │   └── xcuserdata
│   ├── ReachabilitySwift
│   │   ├── LICENSE
│   │   ├── README.md
│   │   └── Sources
│   ├── Realm
│   │   ├── LICENSE
│   │   ├── README.md
│   │   ├── Realm
│   │   ├── build.sh
│   │   ├── core
│   │   └── include
│   ├── RealmSwift
│   │   ├── LICENSE
│   │   ├── README.md
│   │   ├── Realm
│   │   ├── RealmSwift
│   │   └── build.sh
│   ├── Target\ Support\ Files
│   │   ├── Pods-ZMAppChallenge
│   │   ├── Pods-ZMAppChallengeTests
│   │   ├── ReachabilitySwift
│   │   ├── Realm
│   │   ├── RealmSwift
│   │   └── lottie-ios
│   └── lottie-ios
│       ├── LICENSE
│       ├── README.md
│       └── lottie-swift
├── README.md
├── ZMAppChallenge
│   ├── AppDelegate.swift
│   ├── Common
│   │   ├── Connectivity
│   │   ├── Constants
│   │   ├── Protocols
│   │   └── Views
│   ├── DataManagers
│   │   ├── API
│   │   ├── Local
│   │   └── Protocols
│   ├── Info.plist
│   ├── Modules
│   │   ├── Post
│   │   └── PostDetail
│   ├── Resources
│   │   ├── Assets
│   │   ├── CoreData
│   │   ├── JSON
│   │   ├── Locale
│   │   └── Storyboards
│   ├── SceneDelegate.swift
│   └── Services
│       ├── Comment
│       ├── Post
│       └── User
├── ZMAppChallenge.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata
│   └── xcuserdata
│       └── cris.xcuserdatad
├── ZMAppChallenge.xcworkspace
│   ├── contents.xcworkspacedata
│   ├── xcshareddata
│   │   └── IDEWorkspaceChecks.plist
│   └── xcuserdata
│       └── cris.xcuserdatad
└── ZMAppChallengeTests
    ├── Info.plist
    ├── Mock
    │   ├── mockComments.json
    │   ├── mockCommentsNotValues.json
    │   ├── mockNilPost.json
    │   ├── mockPost.json
    │   ├── mockUser.json
    │   ├── mockUserWithNoValues.json
    │   └── mockWithNoValuesPost.json
    ├── ZMAppChallengeTests.swift
    ├── ZMCommentManagmentServiceTests.swift
    ├── ZMDataManagerMockNetworkProvider.swift
    ├── ZMPostManagmentServiceTests.swift
    └── ZMUserManagmentServiceTests.swift
```
