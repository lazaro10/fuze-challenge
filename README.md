# Fuze Challenge

This application lets you know the schedule of Counter-Strike: Global Offensive championship matches

## Features

### Matches

- Live matches
- Matches that will happen
- Pull to refresh
- Pagination

### Match Detail

- Match details
- List of players
- Pull to refresh
- Pagination

## Prerequisites

- Swift 5
- Xcode 13.4.1

## Framework used

All frameworks were installed using SPM

 - [Kingfisher](https://github.com/onevcat/Kingfisher) For downloading and caching images.
 - [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) For validating the layout of the Views

## Architecture

The architecture used was MVVM with some layers of support.

- Repository: Responsible for communicating with services and providing data. 
- Converter: Responsible for converting business models into visual models. 
- Model: Responsible for defining the business model
- ViewModel: Responsible for commanding the presentation rules
- View: Responsible for presenting the layout

## Requirements for tests

For the tests to work correctly, some configurations are necessary.

- iPhone 11
- Dark Appearance activated
- Region: United States
- iPhone Laguage: English

## Demo

### Apperance Dark

![dark](https://user-images.githubusercontent.com/13118511/203831484-b7203fe9-7d21-47a6-a75f-6bce93d57b5e.gif)


### Apperance Light

![light](https://user-images.githubusercontent.com/13118511/203831530-03cf4ef6-7768-4e2f-a633-9eec3dd06266.gif)
