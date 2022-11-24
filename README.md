# Fuze Challenge

This application lets you know the schedule of Counter-Strike: Global Offensive championship matches

# Features

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

- Repository: Layer responsible for communicating with services and providing data. 
- Converter: Layer responsible for converting business models into visual models. 
- Model: Layer responsible for defining the business model
- ViewModel: Layer responsible for commanding the presentation rules
- View: Layer responsible for presenting the layout

## Requirements for tests

For the tests to work correctly, some configurations are necessary.

- iPhone 11 (iOS 14.5)
- Dark Appearance activated
- Region: United States
- iPhone Laguage: English

## Demo

### Apperance Dark
![ezgif-4-2b0d8adfa8](https://user-images.githubusercontent.com/13118511/203706064-30fb9c0d-0f23-4dd4-a416-7b669abe08fb.gif)

### Apperance Light
![ezgif-4-13d5a578e0](https://user-images.githubusercontent.com/13118511/203706378-7c82962f-ac7f-4f8c-b02d-a19881867322.gif)
